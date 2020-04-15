"use strict";
MapApp.controller('MapController', function MapController($scope, $http) {

    let slide = () =>{
        let user = document.querySelector('.user');
        let close = document.querySelector('.sideBar__close');
        let sideBar = document.querySelector('.sideBar__inner');
        let slideLinks = document.querySelectorAll('.sideBar__links li');

        let cont = document.querySelector('.content');


        user.addEventListener('click', () => {
            cont.classList.toggle('content-active');
            slideFunction(sideBar, slideLinks);
        });  

        //Повторение кода, знаю, потом подумаю как избавится, а может просто избавлюсь от крестика
        close.addEventListener('click', () => {
            cont.classList.toggle('content-active');
            slideFunction(sideBar, slideLinks);
        }); 
    }
    slide();
    function slideFunction(sideBar, slideLinks) {
        sideBar.classList.toggle('sideBar-active');
        slideLinks.forEach((link, index) => {
            if (link.style.animation) {
                link.style.animation = ``;
            }
            else {
                link.style.animation = `sideBarLinksFade 0.5s ease forwards ${index / 7 + 0.3}s`;
            }
        });
    }

    $scope.user = JSON.parse(localStorage.getItem('user'));

    $http.post('/includes/dataGetter.php', {desks: true})
    .then(x => {
        console.log(x.data);
        let buildingData = {
            features: x.data.floor
        };

        let roomsData = {
            features: x.data.rooms
        }

        let desksData = {
            features: x.data.desks
        }

        $scope.vectorMapOptions = {
            maxZoomFactor: 4,
            projection: {
                to: function (coordinates) {
                    return [coordinates[0] / 100, coordinates[1] / 100];
                },
        
                from: function (coordinates) {
                    return [coordinates[0] * 100, coordinates[1] * 100];
                }
            },
            controlBar:{
                enabled:false
            },
            layers: [{
                hoverEnabled: false,
                dataSource: buildingData,
                name: "building"
            }, {
                color: "#fff",
                borderColor: "#123424",
                borderWidth: 1,
                label: {
                    enabled: true,
                    dataField: "name"
                },
                dataSource: roomsData,
                name: "rooms"
            }, {
                type: "marker",
                elementType: "image",
                dataField: "url",
                size: 60,
                dataSource: desksData,
                name: "desks"
            }],
            loadingIndicator: {
                show: true
            },
            tooltip: {
                enabled: true,
                contentTemplate: (info, container) => {
                    if(info.layer.name === "desks") {
                        let popUp = document.createElement('div');
                        popUp.className = 'popUp';

                        let avatar = document.createElement('img');
                        avatar.className = 'avatar';
                        avatar.src = `/images/users/${info.attribute('avatar')}`;

                        let name = document.createElement('p');
                        name.innerText = info.attribute('user');

                        let post = document.createElement('span');
                        post.className = 'post';
                        post.innerText = info.attribute('post') + ' ';

                        name.prepend(post);
                        popUp.append(avatar);
                        popUp.append(name);
                        container.append(popUp);
                    }
                }
            }
        };
    });
});