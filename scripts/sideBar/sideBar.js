let slide = () =>{
    let user = document.querySelector('.user');
    let close = document.querySelector('.sideBar__close');
    // let cont = document.querySelector('.nav');
    let sideBar = document.querySelector('.sideBar__inner');
    let slideLinks = document.querySelectorAll('.sideBar__links li');


    user.addEventListener('click', () => {
        // cont.classList.toggle('nav-active');
        slideFunction(sideBar, slideLinks);
    });  

    //Повторение кода, знаю, потом подумаю как избавится, а может просто избавлюсь от крестика
    close.addEventListener('click', () => {
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
