const SAMPLE_ADDRESSES = [
    { address: '789 Test Ave', suburb: 'Brisbane', state: 'QLD', postcode: '4000' },
    { address: '101 Place St', suburb: 'Perth', state: 'WA', postcode: '6000' },
    { address: '124 Latrobe Street', suburb: 'Melbourne', state: 'VIC', postcode: '3000' },
    { address: '246 Clayton Road', suburb: 'Clayton', state: 'VIC', postcode: '3168' }
];

function fetchAddressSuggestions(element, type) {
    const query = element.value;

    if (query.length < 2) { // Don't fetch for very short queries
        document.getElementById('addressSuggestions').innerHTML = '';
        return;
    }

    let suggestions = '';

    SAMPLE_ADDRESSES.forEach(address => {
        switch (type) {
            case 'address':
                if (address.address.toLowerCase().includes(query.toLowerCase())) {
                    suggestions += `<div onclick="setAddress('${address.address}', '${address.suburb}', '${address.state}', '${address.postcode}')">${address.address}</div>`;
                }
                break;
            case 'suburb':
                if (address.suburb.toLowerCase().includes(query.toLowerCase())) {
                    suggestions += `<div onclick="setAddress('${address.address}', '${address.suburb}', '${address.state}', '${address.postcode}')">${address.suburb}</div>`;
                }
                break;
            case 'state':
                if (address.state.toLowerCase().includes(query.toLowerCase())) {
                    suggestions += `<div onclick="setAddress('${address.address}', '${address.suburb}', '${address.state}', '${address.postcode}')">${address.state}</div>`;
                }
                break;
            case 'postcode':
                if (address.postcode.toLowerCase().includes(query.toLowerCase())) {
                    suggestions += `<div onclick="setAddress('${address.address}', '${address.suburb}', '${address.state}', '${address.postcode}')">${address.postcode}</div>`;
                }
                break;
        }
    });

    document.getElementById('addressSuggestions').innerHTML = suggestions;
}

function setAddress(address, suburb, state, postcode) {
    document.getElementById('address').value = address;
    document.getElementById('suburb').value = suburb;
    document.getElementById('state').value = state;
    document.getElementById('postcode').value = postcode;
    const suggestionsDiv = document.getElementById('addressSuggestions');
    const children = suggestionsDiv.children;
    for (let i = 0; i < children.length; i++) {
        children[i].classList.remove('blurred-background');
    }
    event.target.classList.add('blurred-background'); // Add blur to clicked suggestion
    document.getElementById('addressSuggestions').innerHTML = ''; // Clear suggestions after setting the values
}
