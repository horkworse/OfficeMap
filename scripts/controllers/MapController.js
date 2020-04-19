"use strict";
MapApp.controller('MapController', function MapController($scope, $http, $location) {
    /*Меню октрытие*/
    let openNav = () =>{
        let avatar = document.getElementById('avatar');
        let user__nav = document.querySelector('.user__nav');

        avatar.addEventListener('click', () => {
            user__nav.classList.toggle('user__nav--active');

        });  
    }
    openNav();

    /*Сайд бар*/
    let slide = () =>{
        let user = document.querySelector('.sideBar__open');
        let close = document.querySelector('.sideBar__close');
        let sideBar = document.querySelector('.sideBar__inner');
        let slideLinks = document.querySelectorAll('.sideBar__links li');
        let user__nav = document.querySelector('.user__nav');
        // let cont = document.querySelector('.content');


        user.addEventListener('click', () => {
            // cont.classList.toggle('content-active');
            user__nav.classList.remove('user__nav--active');
            slideFunction(sideBar, slideLinks);
        });  

        //Повторение кода, знаю, потом подумаю как избавится, а может просто избавлюсь от крестика
        close.addEventListener('click', () => {
            // cont.classList.toggle('content-active');
            slideFunction(sideBar, slideLinks);
        }); 
    }
    slide();

    function slideFunction(sideBar, slideLinks) {
        sideBar.classList.toggle('sideBar-active');
        slideLinks.forEach((link, index) => {
            if (link.style.animation) {
                link.style.animation = '';
            }
            else {
                link.style.animation = `sideBarLinksFade 0.5s ease forwards ${index / 7 + 0.3}s`;
            }
        });
    }
    
    /* Selct выбор иконки */
    document.getElementById("statusSelect").addEventListener("change", function(){
        let st = document.getElementById("statusSelect").value;

        if(+st == 1){
            document.getElementById('stat').setAttribute("class", "fas fa-fire");
        }else if(+st == 2){
            document.getElementById('stat').setAttribute("class", "fas fa-briefcase");
        }else if(+st == 3){
            document.getElementById('stat').setAttribute("class", "fas fa-utensils");
        }else if(+st == 4){
            document.getElementById('stat').setAttribute("class", "fas fa-wine-bottle");
        }
    });
    
    
    $scope.user = JSON.parse(localStorage.getItem('user'));
    $scope.logout = function () {
        $http.post('/includes/dataGetter.php', {logout: true});
        localStorage.removeItem('user');
        $location.path('/sign-in');
    }

    $http.post('/includes/dataGetter.php', {desks: true})
    .then(x => {
        console.log(x.data.desks);
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
            controlBar: {
                enabled: false
            },
            maxZoomFactor: 10,
            projection: {
                to: function (coordinates) {
                    return [coordinates[0] / 100, coordinates[1] / 100];
                },
        
                from: function (coordinates) {
                    return [coordinates[0] * 100, coordinates[1] * 100];
                }
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
            }/*, {
                type: "user",
                elementType: "image",
                dataField: "url",
                size: 60,
                dataSource: {
                    
                },
                name: "desks"
            }*/],
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

                        name.prepend(post)
                        popUp.append(avatar);
                        popUp.append(name);
                        container.append(popUp);
                    }
                }
            }
        };
    });
});