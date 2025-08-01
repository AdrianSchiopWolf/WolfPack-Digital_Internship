const handleButtonClickNavigation = (url) => {
  window.location.href = url;
};

const toggleDropdown = (element) => {
  const targetDropdown = document.getElementById(element);

  const allDropDowns = document.querySelectorAll('.dropdown-content');

  allDropDowns.forEach((dropdown) => {
    if (dropdown.id !== element && dropdown.classList.contains('show')) {
      dropdown.classList.remove('show');
    }
  });
  if (targetDropdown) {
    targetDropdown.classList.toggle('show');
  }
};

window.onclick = (event) => {
  if (!event.target.matches('.dropdown-button')) {
    const dropdowns = document.getElementsByClassName('dropdown-content');
    for (let i = 0; i < dropdowns.length; i++) {
      dropdowns[i].classList.remove('show');
    }
  }
};

document.addEventListener('DOMContentLoaded', () => {
  const rangeMin = document.getElementById('range-min');
  const rangeMax = document.getElementById('range-max');
  const minPrice = document.getElementById('min-price');
  const maxPrice = document.getElementById('max-price');
  const sliderTrack = document.querySelector('.slider-track');
  // const productList = document.getElementById('productList');
  // let selectedCategory = 'All';
  // let selectedSort = 'null';

  // const categoryLinks = document.querySelectorAll(
  //   '.dropdown-content .category-dropdown a'
  // );
  // const sortLinks = document.querySelectorAll(
  //   '.dropdown-content .sorting-dropdown a'
  // );
  
  const updateSliderTrack = () => {
    const minVal = parseInt(rangeMin.value);
    const maxVal = parseInt(rangeMax.value);

    minPrice.innerText = `${minVal}$`;
    maxPrice.innerText = `${maxVal}$`;

    const percentMin = (minVal / parseInt(rangeMin.max)) * 100;
    const percentMax = (maxVal / parseInt(rangeMax.max)) * 100;

    sliderTrack.style.background = `linear-gradient(to right, rgb(199, 198, 198) ${percentMin}%, orange ${percentMin}%, orange ${percentMax}%, rgb(199, 198, 198) ${percentMax}%)`;
  };
  // const fetchProducts = async () => {
  //   const params = new URLSearchParams({
  //     category: selectedCategory,
  //     sort: selectedSort,
  //     min_price: parseInt(rangeMin.value),
  //     max_price: parseInt(rangeMax.value)
  //   });

  //   try {
  //     const response = await fetch(`/products.json?${params.toString()}`, {headers: {'Accept': 'application/json'}});
  //     if (!response.ok) throw new Error('Network response was not ok');
  //     const data = await response.json();
  //     renderProducts(data);
  //   } catch (error) {
  //     console.error('Error fetching products:', error);
  //   }
  // };

  // const renderProducts = (products) => {
  //   productList.innerHTML = '';
  //   products.forEach((product) => {
  //     const card = document.createElement('div');
  //     card.className = 'product-card';
  //     card.innerHTML = `
  //       <img src="${product.photo}" alt="${product.name}">
  //       <h3>${product.name}</h3>
  //       <p class="category">${product.category}</p>
  //       <p class="price">$${product.price}</p>
  //     `;
  //     productList.appendChild(card);
  //   });
  // };

  // categoryLinks.forEach((link) => {
  //   link.addEventListener('click', (e) => {
  //     e.preventDefault();
  //     selectedCategory = link.getAttribute('data-category');
  //     fetchProducts();
  //   });
  // });

  // sortLinks.forEach((link) => {
  //   link.addEventListener('click', (e) => {
  //     e.preventDefault();
  //     selectedSort = link.getAttribute('data-sort');
  //     fetchProducts();
  //   });
  // });

  rangeMin.addEventListener('input', () => {
    if (parseInt(rangeMin.value) > parseInt(rangeMax.value) - 5) {
      rangeMin.value = parseInt(rangeMax.value) - 5;
    }
    updateSliderTrack();
  });

  rangeMax.addEventListener('input', () => {
    if (parseInt(rangeMax.value) < parseInt(rangeMin.value) + 5) {
      rangeMax.value = parseInt(rangeMin.value) + 5;
    }
    updateSliderTrack();
  });

  updateSliderTrack();
  // fetchProducts();
});
