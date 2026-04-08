/**
 * Shared utility for handling Master Data cascading dropdowns in Consignment Modules.
 * API endpoints based on collection.json - 00 - Master Data:
 * - GET /consignment/api/master-data/companies
 * - GET /consignment/api/master-data/stores?company={company}
 * - GET /consignment/api/master-data/suppliers?company={company}&store={store}
 * - GET /consignment/api/master-data/contracts?company={company}&store={store}&supplierCode={supplierCode}
 * - GET /consignment/api/master-data/items?company={company}&store={store}&supplierCode={supplierCode}&supplierContract={contract}
 * 
 * Requires api-client.js and jQuery.
 */

var ConsignmentMasterData = {
    // Selectors for standard dropdowns
    selectors: {
        company: '#company, select[name="company"]',
        store: '#store, select[name="store"], select[name="receivingStore"]',
        supplier: '#supplierCode, select[name="supplierCode"]',
        contract: '#supplierContract, select[name="supplierContract"]',
        item: '#itemCode, select[name="itemCode"]'
    },

    init: function() {
        this.bindEvents();
        // Trigger initial load for company
        this.loadCompanies();
    },

    bindEvents: function() {
        var self = this;
        
        // Company change -> load stores
        $(document).on('change', self.selectors.company, function() {
            var val = $(this).val();
            self.clearDropdown(self.selectors.store, 'Select Store');
            self.clearDropdown(self.selectors.supplier, 'Select Supplier');
            self.clearDropdown(self.selectors.contract, 'Select Contract');
            self.clearDropdown(self.selectors.item, 'Select Item');
            if (val) {
                self.loadStores(val);
            }
        });

        // Store change -> load suppliers
        $(document).on('change', self.selectors.store, function() {
            var company = $(self.selectors.company).val();
            var val = $(this).val();
            self.clearDropdown(self.selectors.supplier, 'Select Supplier');
            self.clearDropdown(self.selectors.contract, 'Select Contract');
            self.clearDropdown(self.selectors.item, 'Select Item');
            if (company && val) {
                self.loadSuppliers(company, val);
            }
        });

        // Supplier change -> load contracts
        $(document).on('change', self.selectors.supplier, function() {
            var company = $(self.selectors.company).val();
            var store = $(self.selectors.store).val();
            var val = $(this).val();
            self.clearDropdown(self.selectors.contract, 'Select Contract');
            self.clearDropdown(self.selectors.item, 'Select Item');
            if (company && store && val) {
                self.loadContracts(company, store, val);
            }
        });
        
        // Contract change -> load items
        $(document).on('change', self.selectors.contract, function() {
            var company = $(self.selectors.company).val();
            var store = $(self.selectors.store).val();
            var supplier = $(self.selectors.supplier).val();
            var val = $(this).val();
            self.clearDropdown(self.selectors.item, 'Select Item');
            if (company && store && supplier && val) {
                self.loadItems(company, store, supplier, val);
            }
        });
    },

    clearDropdown: function(selector, placeholder) {
        $(selector).empty().append('<option value="">' + placeholder + '</option>');
    },

    populateDropdown: function(selector, placeholder, dataArray, selectedValue) {
        var $el = $(selector);
        $el.empty().append('<option value="">' + placeholder + '</option>');
        if (dataArray && dataArray.length > 0) {
            dataArray.forEach(function(item) {
                $el.append($('<option></option>').attr('value', item).text(item));
            });
        }
        if (selectedValue) {
            $el.val(selectedValue);
        }
    },

    /**
     * Get Companies
     * GET /consignment/api/master-data/companies
     * Response: { message: "success", status: 200, data: ["COMP01", "COMP02"] }
     */
    loadCompanies: async function(selectedValue) {
        try {
            var res = await ApiClient.get('CONSIGNMENT', '/master-data/companies');
            var data = res.data || res;
            this.populateDropdown(this.selectors.company, 'Select Company', data, selectedValue);
            if (selectedValue) {
                $(this.selectors.company).trigger('change');
            }
        } catch (e) {
            console.error('Failed to load companies:', e);
        }
    },

    /**
     * Get Stores by Company
     * GET /consignment/api/master-data/stores?company={company}
     * Response: { message: "success", status: 200, data: ["STORE01", "STORE02", "STORE03"] }
     */
    loadStores: async function(company, selectedValue) {
        try {
            var res = await ApiClient.get('CONSIGNMENT', '/master-data/stores?company=' + encodeURIComponent(company));
            var data = res.data || res;
            this.populateDropdown(this.selectors.store, 'Select Store', data, selectedValue);
            if (selectedValue) {
                $(this.selectors.store).trigger('change');
            }
        } catch (e) {
            console.error('Failed to load stores:', e);
        }
    },

    /**
     * Get Suppliers by Company+Store
     * GET /consignment/api/master-data/suppliers?company={company}&store={store}
     * Response: { message: "success", status: 200, data: ["SUPP001", "SUPP002"] }
     */
    loadSuppliers: async function(company, store, selectedValue) {
        try {
            var url = '/master-data/suppliers?company=' + encodeURIComponent(company) + '&store=' + encodeURIComponent(store);
            var res = await ApiClient.get('CONSIGNMENT', url);
            var data = res.data || res;
            this.populateDropdown(this.selectors.supplier, 'Select Supplier', data, selectedValue);
            if (selectedValue) {
                $(this.selectors.supplier).trigger('change');
            }
        } catch (e) {
            console.error('Failed to load suppliers:', e);
        }
    },

    /**
     * Get Contracts by Supplier
     * GET /consignment/api/master-data/contracts?company={company}&store={store}&supplierCode={supplierCode}
     * Response: { message: "success", status: 200, data: ["CONTRACT-2024-001", "CONTRACT-2024-002"] }
     */
    loadContracts: async function(company, store, supplierCode, selectedValue) {
        try {
            var url = '/master-data/contracts?company=' + encodeURIComponent(company) + 
                      '&store=' + encodeURIComponent(store) + 
                      '&supplierCode=' + encodeURIComponent(supplierCode);
            var res = await ApiClient.get('CONSIGNMENT', url);
            var data = res.data || res;
            this.populateDropdown(this.selectors.contract, 'Select Contract', data, selectedValue);
            if (selectedValue) {
                $(this.selectors.contract).trigger('change');
            }
        } catch (e) {
            console.error('Failed to load contracts:', e);
        }
    },

    /**
     * Get Items by Supplier+Contract
     * GET /consignment/api/master-data/items?company={company}&store={store}&supplierCode={supplierCode}&supplierContract={contract}
     * Response: { message: "success", status: 200, data: ["ITEM001", "ITEM002", "ITEM003"] }
     */
    loadItems: async function(company, store, supplierCode, supplierContract, selectedValue) {
        try {
            var url = '/master-data/items?company=' + encodeURIComponent(company) + 
                      '&store=' + encodeURIComponent(store) + 
                      '&supplierCode=' + encodeURIComponent(supplierCode) +
                      '&supplierContract=' + encodeURIComponent(supplierContract);
            var res = await ApiClient.get('CONSIGNMENT', url);
            var data = res.data || res;
            this.populateDropdown(this.selectors.item, 'Select Item', data, selectedValue);
        } catch (e) {
            console.error('Failed to load items:', e);
        }
    },
    
    /**
     * Get all current values from dropdowns
     */
    getValues: function() {
        return {
            company: $(this.selectors.company).val(),
            store: $(this.selectors.store).val(),
            supplier: $(this.selectors.supplier).val(),
            contract: $(this.selectors.contract).val(),
            item: $(this.selectors.item).val()
        };
    },
    
    /**
     * Set all dropdown values and trigger cascade loading
     * @param {Object} values - { company, store, supplier, contract, item }
     */
    setValues: function(values) {
        var self = this;
        if (!values) return;
        
        if (values.company) {
            self.loadCompanies(values.company).then(function() {
                if (values.store) {
                    self.loadStores(values.company, values.store).then(function() {
                        if (values.supplier) {
                            self.loadSuppliers(values.company, values.store, values.supplier).then(function() {
                                if (values.contract) {
                                    self.loadContracts(values.company, values.store, values.supplier, values.contract).then(function() {
                                        if (values.item) {
                                            self.loadItems(values.company, values.store, values.supplier, values.contract, values.item);
                                        }
                                    });
                                }
                            });
                        }
                    });
                }
            });
        }
    },
    
    /**
     * For manual triggering of cascading setup from existing loaded values
     * @deprecated Use setValues() instead
     */
    triggerCascade: function() {
        var values = this.getValues();
        this.setValues(values);
    }
};

window.ConsignmentMasterData = ConsignmentMasterData;
