"use strict";
MapApp.controller('MapController', function MapController($scope, $http, $location) {
    
    let config = {
        maxZoom: 10,
        iconSize: 20
    }
        
    /*Меню октрытие*/
    openNav();

    /*Сайд бар*/
    slide();

    /*Недопасхалка, потом зафигачим норм пасхалку*/
    onKonamiCode(function () {
        let fade = document.getElementById('fade');
        let pas = document.getElementById('pashalka');
        pas.style.display = 'flex';
        fade.style.display = 'block';
        pas.style.animation = `pas 0.7s ease`;

        fade.addEventListener('click', () => {
            pas.style.display = 'none';
            fade.style.display = 'none';
        }); 
    });

    // aPanel();

    searchField();

    // $http.post('/includes/dataGetter.php', { getStatuses: true })
    // .then(x => {
    //     let data = x.data;

    //     for (var i = 0; i < data.length; i++) {
    //         $scope.statuses.push({
    //             'name': data[i],
    //             'value': i
    //         })
    //     }
    // })
    $scope.userDeskId = 0;
    $scope.user = JSON.parse(localStorage.getItem('user'));

    $scope.statuses = [
        { name: "Не беспокоить", value: "0" },
        { name: "Отошел", value: "1" },
        { name: "Работает", value: "2" },
        { name: "Не работает", value: "3" }
    ];

    $scope.status = $scope.statuses.find(item => item.name == $scope.user.status);

    changeStatus($scope.status);

    /* выход юзера из учетки*/
    $scope.logout = function () {
        $http.post('/includes/dataGetter.php', {logout: true});
        localStorage.removeItem('user');
        $scope.user = null;
        $location.path('/sign-in');
    };
    
    $scope.editForm = (user) => {
        let form = document.querySelectorAll('.inputs');
        if (form[1].style.cursor == 'text')
        {
            console.log(1);
            $http.post('/includes/dataGetter.php', {
                update: true,
                data: {
                    id: user.id,
                    social: user.social,
                    phone: user.phone
                }
            })
            .then(() => localStorage.user = JSON.stringify($scope.user));
        }
        form.forEach((item) => {
            if (item.id != 'email')
            {
                item.toggleAttribute('readonly');
                item.style.cursor = (item.style.cursor == 'text') ? '' : 'text';
                item.style.animation  = item.style.borderBottom  == '' ? `sideBarLinksBorder 0.2s ease` : `sideBarLinksUnBorder 0.2s ease` ;
                item.style.borderBottom  = item.style.borderBottom  == '' ? '2px solid rgba(0,0,0,.5)' : '';
            }
        });
    };

    /* карта */
    $http.post('/includes/dataGetter.php', {desks: true})
    .then(x => {
        /* формируем объекты с данными о этаже, комнатах и столах */
        let buildingData = {
            hoverEnabled: false,
            dataSource: { features: x.data.floor },
            name: "building"
        };

        let roomsData = {
            color: "#fff",
            borderColor: "#123424",
            borderWidth: 1,
            label: {
                enabled: true,
                dataField: "name"
            },
            dataSource: { features: x.data.rooms },
            name: "rooms"
        };

        let desksData = {
            type: "marker",
            elementType: "image",
            dataField: "url",
            size: config.iconSize,
            dataSource: { features: x.data.desks },
            name: "desks"
        };

        console.log(desksData.dataSource.features);

        let map = $("#vector-map").dxVectorMap("instance");

        /* подгрузка карты */
        $scope.vectorMapOptions = {
            controlBar: {
                enabled: false
            },
            maxZoomFactor: 10,
            projection: {
                to: (coordinates) => [coordinates[0] / 100, coordinates[1] / 100],
                from: (coordinates) => [coordinates[0] * 100, coordinates[1] * 100]
            },
            layers: [
                buildingData,
                roomsData,
                desksData
            ],
            loadingIndicator: {
                show: true
            },
            onInitialized : (e) => {


            },
            /* вывод popUp при наведении выши на стол */
            tooltip: {
                enabled: true,
                contentTemplate: (e, container) => {

                    if ($scope.isDraggable ) {
                        let currentDesk = desksData.dataSource.features[$scope.targetId];
                        currentDesk.geometry.coordinates = $scope.coordinates;           

                        map.option("layers[2].dataSource", desksData.dataSource);
                        map.render();
                    }
// Говно снизу перенести в отдельную функцию (hork)
                    if (e.layer.name === "desks" && !$scope.isDraggable) {
                        let popUp = document.createElement('div');
                        popUp.className = 'popUp';

                        let avatar = document.createElement('img');
                        avatar.className = 'avatar';
                        avatar.src = `/images/users/${e.attribute('avatar')}`;

                        let name = document.createElement('p');
                        name.innerText = e.attribute('user');

                        let post = document.createElement('span');
                        post.className = 'post';
                        post.innerText = e.attribute('post');

                        let status = document.createElement('p');
                        status.className = 'status';
                        status.innerText = e.attribute('status');

                        let phone = document.createElement('p');
                        phone.className = ''; // тут
                        phone.innerText = e.attribute('phone');

                        let social = document.createElement('p');
                        social.className = ''; // и тут
                        social.innerText = e.attribute('social');

                        switch (status.innerText) {
                            case 'Не работает':
                                status.style.color = '#19FF4F';
                                break;
                            case 'Не беспокоить':
                                status.style.color = '#FF0D22';
                                break;
                            case 'Отошел':
                                status.style.color = '#0122FF';
                                break;
                            default:
                                status.style.color = '#FFC400';
                                break;
                        }

                        name.prepend(post);
                        name.append(status);
                        popUp.append(avatar);
                        popUp.append(name);
                        popUp.append(phone);
                        popUp.append(social);
                        container.append(popUp);
                    }
                }
            },
            onZoomFactorChanged: (e) => {
                desksData.size = config.iconSize * e.zoomFactor;
                map.getLayerByName('desks').getElements().forEach((x, i, arr) => {
                    x.applySettings(desksData);
                });
                map.render();
            },
            onDrawn: (e) => {
                e.element.on('mousemove', function(event) {
                    let render = false;
                    $scope.coordinates = map.convertToGeo(event.clientX, event.clientY );
                })

                $scope.changeStatus = (status) => {
                    
                    changeStatus(status);
                    $scope.user.status = status.name;
                    localStorage.user = JSON.stringify($scope.user)

                    let userData = {
                        id: $scope.user.id,
                        status: status.name,
                    };

                    $http.post("includes/dataGetter.php", userData);
                    let desks = desksData.dataSource.features;

                    for (let i = 0; i < desks.length; i++) {
                        if (desks[i].properties.id == $scope.user.id) {
                            desks[i].properties.status = status.name;
                            map.option("layers[2].dataSource", desksData.dataSource);
                            map.render();

                            break;
                        }
                    }
                }

                $scope.search = function () {
                    let input = document.getElementById('search__input');

                    $http.post('/includes/dataGetter.php', {
                        search: true,
                        data: { key: input.value }
                    })
                    .then(x => {
                        let resultList = document.getElementsByClassName('list')[0];
                        resultList.innerHTML = "";

                        x.data.forEach(employee => {
                            let item = document.createElement("li");
                            let name = document.createElement("span");
                            let post = document.createElement("span");
                            let status = document.createElement("span");
                            let link = document.createElement("a");

                            name.innerText = employee.surname + " " + employee.name + " ";
                            post.innerText = employee.post + " ";
                            status.innerText = employee.status
                            
                            link.append(name, post, status);
                            link.href = "#";
                            item.append(link);

                            // console.log(employee.id);
                            // console.log(item);

                            resultList.append(item);

                            item.addEventListener("click", function(e) {
                                let desks = desksData.dataSource.features;
                                $scope.userDeskId = employee.id;
                                console.log(employee.id);

                                // for (let i = 0; i < desks.length; i++) {
                                //     if (desks[i].properties.id == employee.id) {
                                        
                                //         let prevImagePath = desks[i].properties.url;
                                //         desks[i].properties.url = '/images/selected.png';
                                //         input.value = item.innerText;

                                //         map.center(desks[i].geometry.coordinates);
                                //         map.zoomFactor(4);
                                //         map.option("layers[2].dataSource", desksData.dataSource);
                                //         map.render();

                                //         setTimeout(() => {
                                //             desks[i].properties.url = prevImagePath;
                                //             map.option("layers[2].dataSource", desksData.dataSource);
                                //             map.render();
                                //         }, 3000)
                                //         break;
                                //     }
                                // }
                            });
                        });
                    });
                };

                $scope.goTo = (userDeskId) => {
                    
                }
            },
            onClick: (e) => {

                if (e.target !== undefined && e.target.layer.name == 'desks') {
                    let index = e.target.index;
                    let currentDesk = desksData.dataSource.features[index];

                    $scope.tempImage = $scope.tempImage === undefined ? currentDesk.properties.url : $scope.tempImage;

                    if ($scope.isDraggable && currentDesk.properties.id == $scope.user.id) {
                        $scope.isDraggable = false;
                        currentDesk.properties.url = $scope.tempImage;

                        let dataDesk = {
                            id: currentDesk.properties.id,
                            x: currentDesk.geometry.coordinates[0],
                            y: currentDesk.geometry.coordinates[1],
                            updateDesk: true
                        };
                        $http.post("/includes/dataGetter.php", dataDesk);
                        console.log("moving is end");
                    }
                    else if (!$scope.isDraggable && currentDesk.properties.id == $scope.user.id) {
                        $scope.isDraggable = true;
                        currentDesk.properties.url = '/images/selected.png';
                        console.log("moving is start");
                    }
                    $scope.targetId = index;
                    
                    map.option("layers[2].dataSource", desksData.dataSource);
                    map.render();
                }
            }
        };
    });
});
