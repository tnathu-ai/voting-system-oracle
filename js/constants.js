// This file contains constants that can be used throughout the project.

// address
export const SAMPLE_ADDRESSES = [
    { address: '789 Test Ave', suburb: 'Brisbane', state: 'QLD', postcode: '4000' },
    { address: '101 Place St', suburb: 'Perth', state: 'WA', postcode: '6000' },
    { address: '124 Latrobe Street', suburb: 'Melbourne', state: 'VIC', postcode: '3000' },
    { address: '246 Clayton Road', suburb: 'Clayton', state: 'VIC', postcode: '3168' }
];

// electorate name
export const SAMPLE_ELECTORATE = {
    HOTHAM: 'Hotham',
    MELBOURNE: 'Melbourne'
}

// candidates
export const HOTHAM_CANDIDATES = [
    { name: 'SOK, Edward', party: 'Liberal Democrats' },
    { name: "O'NEIL, Clare", party: 'Australian Labor Party' },
    { name: 'WILLOUGHBY, Louisa', party: 'The Greens' },
    { name: 'RIDGWAY, Bruce Scott', party: 'United Australia Party' },
    { name: 'TULL, Roger', party: "Pauline Hanson's One Nation" },
    { name: 'BEVINAKOPPA, Savitri', party: 'Liberal' }
];

export const MELBOURNE_CANDIDATES = [
    { name: 'BORG, Justin', party: 'United Australia Party' },
    { name: 'PATERSON, Keir', party: 'Australian Labor Party' },
    { name: 'BANDT, Adam', party: 'The Greens' },
    { name: 'DAMCHES, James', party: 'Liberal' },
    { name: 'PEPPARD, Richard', party: 'Liberal Democrats' },
    { name: 'ROBSON, Scott', party: 'Independent' },
    { name: 'STRAGAN, Walter', party: "Pauline Hanson's One Nation" },
    { name: 'POON, Bruce', party: 'Animal Justice Party' },
    { name: 'BOLGER, Colleen', party: 'Victorian Socialists' }
];

// voters
export const VOTERS = [
    { name: 'Joe Bloggs', address: '124 Latrobe Street Melbourne VIC 3000', electorate: SAMPLE_ELECTORATE.MELBOURNE },
    { name: 'Penny Chan', address: '246 Clayton Road, Clayton VIC 3168', electorate: SAMPLE_ELECTORATE.HOTHAM }
];
