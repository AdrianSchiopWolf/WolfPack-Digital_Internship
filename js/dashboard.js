document.addEventListener('DOMContentLoaded', () => {
  const form = document.getElementById('productForm');
  const productsContainer = document.getElementById('productsContainer');

  const loadProducts = () => {
    const products = JSON.parse(localStorage.getItem('products')) || [];
    productsContainer.innerHTML = '';

    products.forEach((product, index) => {
      const card = document.createElement('div');
      card.className = 'product-card';
      card.innerHTML = `
                <img src="${product.photo}" alt="${product.name}">
                <h3>${product.name}</h3>
                <p class="category">${product.category}</p>
                <p class="price">$${product.price}</p>
                <button data-index="${index}">Delete</button>
            `;
      productsContainer.appendChild(card);
    });
  };

  const saveProduct = (product) => {
    const products = JSON.parse(localStorage.getItem('products')) || [];
    products.push(product);
    localStorage.setItem('products', JSON.stringify(products));
    loadProducts();
  };

  const deleteProduct = (index) => {
    const products = JSON.parse(localStorage.getItem('products')) || [];
    products.splice(index, 1);
    localStorage.setItem('products', JSON.stringify(products));
    loadProducts();
  };

  form.addEventListener('submit', (e) => {
    e.preventDefault();
    const name = document.getElementById('productName').value.trim();
    const category = document.getElementById('productCategory').value.trim();
    const price = document.getElementById('productPrice').value.trim();
    const photoFile = document.getElementById('productPhoto').value.trim();

    if (!name || !category || !price || !photoFile)
      return alert('Please fill in all fields.');

    const product = {
      name: name,
      category: category,
      price: price,
      photo: photoFile,
    };

    saveProduct(product);
    form.reset();
  });
  productsContainer.addEventListener('click', (e) => {
    if (e.target.tagName === 'BUTTON') {
      const index = e.target.getAttribute('data-index');
      deleteProduct(index);
    }
  });
  loadProducts();
});
