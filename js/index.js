const handleButtonClickNavigation = (url)=>{
   window.location.href= url;
}

const toggleDropdown =(element)=>{
    const targetDropdown = document.getElementById(element);

    const allDropDowns = document.querySelectorAll(".dropdown-content");

   allDropDowns.forEach(dropdown =>{
    if(dropdown.id !== element && dropdown.classList.contains("show")){
        dropdown.classList.remove("show")
    }
   })
   if(targetDropdown){
    targetDropdown.classList.toggle("show");
   }

}



window.onclick = (event)=>{
    if(!event.target.matches('.dropdown-button')){
        const dropdowns = document.getElementsByClassName("dropdown-content");
        for(let i = 0; i< dropdowns.length;i++){
            dropdowns[i].classList.remove('show');
        }
    }
}
document.addEventListener('DOMContentLoaded', () => {
    const rangeMin = document.getElementById('range-min');
    const rangeMax = document.getElementById('range-max');
    const minPrice = document.getElementById('min-price');
    const maxPrice = document.getElementById('max-price');
    const sliderTrack = document.querySelector('.slider-track');
    const productList = document.getElementById('productList');
    let selectedCategory ="All";
    let selectedSort = "null";
    const products = [
        {
            name: "Pasta carbonara",
            category: "Second Courses",
            price: 9.00,
            image: "img/carbonara.png"
        },
        {
            name: "Chicken Soup",
            category: "Entrees",
            price: 13.00,
            image: "img/chicken_soup.png"
        },
        {
            name: "Vitamin Salad",
            category: "Salads",
            price: 7.00,
            image: "img/vitamin_salad.png"
        },
        {
            name: "Pasta With Walnut",
            category: "Second Courses",
            price: 25.00,
            image: "img/pasta_walnut.png"
        },
        {
            name: "Pizza Margherita",
            category: "Second Courses",
            price: 10.00,
            image: "img/pizza_margherita.png"
        }
    ];

    if (!rangeMin || !rangeMax || !minPrice || !maxPrice || !sliderTrack) {
        console.error('Slider elements not found in DOM');
        return;
    }

    const updateSliderTrack = ()=> {
        const minVal = parseInt(rangeMin.value);
        const maxVal = parseInt(rangeMax.value);

        minPrice.innerText = `${minVal}$`;
        maxPrice.innerText = `${maxVal}$`;

        const percentMin = (minVal / parseInt(rangeMin.max)) * 100;
        const percentMax = (maxVal / parseInt(rangeMax.max)) * 100;

        sliderTrack.style.background = `linear-gradient(to right, rgb(199, 198, 198) ${percentMin+2}%, orange ${percentMin}%, orange ${percentMax}%, rgb(199, 198, 198) ${percentMax}%)`;
    }

    const renderProducts = ()=>{
        productList.innerHTML='';
        const minVal = parseInt(rangeMin.value);
        const maxVal = parseInt(rangeMax.value);

        const filteredProducts = products.filter(product => {
            const inPriceRange =product.price >= minVal && product.price <= maxVal
            const inCategory = selectedCategory === "All" || product.category === selectedCategory;
            return inPriceRange && inCategory;
        });

        if(selectedSort === "asc")
            filteredProducts.sort((a,b) => a.price -b.price )
        else if (selectedSort ==="desc"){
            filteredProducts.sort((a,b)=>b.price-a.price)
        }

        filteredProducts.forEach(product =>{
            const card = document.createElement('div');
            card.className = 'product-card';
            card.innerHTML = `
                <img src="${product.image}" alt="${product.name}">
                <h3>${product.name}</h3>
                <p class="category">${product.category}</p>
                <p class="price">$${product.price.toFixed(2)}</p>
            `;
            productList.appendChild(card);
        })
    }

    const categoryLinks = document.querySelectorAll('.dropdown-content .category-dropdown a');
    const sortLinks = document.querySelectorAll('.dropdown-content .sorting-dropdown a');
    categoryLinks.forEach(link =>{
        link.addEventListener('click', (e) =>{
            e.preventDefault();
            selectedCategory = link.getAttribute('data-category');
            renderProducts();
        })
    })

    sortLinks.forEach(link =>{
        link.addEventListener('click', (e)=>{
            e.preventDefault();
            selectedSort =link.getAttribute('data-sort');
            renderProducts();
        })
    })

    rangeMin.addEventListener('input', () => {
        if (parseInt(rangeMin.value) > parseInt(rangeMax.value) - 5) {
            rangeMin.value = parseInt(rangeMax.value) - 5;
        }
        updateSliderTrack();
        renderProducts();
    });

    rangeMax.addEventListener('input', () => {
        if (parseInt(rangeMax.value) < parseInt(rangeMin.value) + 5) {
            rangeMax.value = parseInt(rangeMin.value) + 5;
        }
        updateSliderTrack();
        renderProducts();
    });

    updateSliderTrack();
    renderProducts();



});






