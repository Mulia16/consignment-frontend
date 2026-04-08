/**
 * Shared utility for handling Master Data cascading dropdowns in Consignment Modules.
 * Requires api-client.js and jQuery.
 */

var ConsignmentMasterData = {
    // Selectors for standard dropdowns
    selectors: {
        company: '#company, select[name="company"]',
        store: '#store, select[name="store"], select[name="receivingStore"]',
        supplier: '#supplierCode, select[name="supplierCode"]',
        contract: '#supplierContract, select[name="supplierContract"]'
    },

    init: function() {
        this.bindEvents();
        // Trigger initial load for company
        this.loadCompanies();
    },

    bindEvents: function() {
        var self = this;
        
        $(document).on('change', self.selectors.company, function() {
            var val = $(this).val();
            self.clearDropdown(self.selectors.store, 'Select Store');
            self.clearDropdown(self.selectors.supplier, 'Select Supplier');
            self.clearDropdown(self.selectors.contract, 'Select Contract');
            if (val) {
                self.loadStores(val);
            }
        });

        $(document).on('change', self.selectors.store, function() {
            var company = $(self.selectors.company).val();
            var val = $(this).val();
            self.clearDropdown(self.selectors.supplier, 'Select Supplier');
            self.clearDropdown(self.selectors.contract, 'Select Contract');
            if (company && val) {
                self.loadSuppliers(company, val);
            }
        });

        $(document).on('change', self.selectors.supplier, function() {
            var company = $(self.selectors.company).val();
            var store = $(self.selectors.store).val();
            var val = $(this).val();
            self.clearDropdown(self.selectors.contract, 'Select Contract');
            if (company && store && val) {
                self.loadContracts(company, store, val);
            }
        });
        
        // When contract changes, you may want to refresh items or similar logic
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

    loadContracts: async function(company, store, supplierCode, selectedValue) {
        try {
            var url = '/master-data/contracts?company=' + encodeURIComponent(company) + '&store=' + encodeURIComponent(store) + '&supplierCode=' + encodeURIComponent(supplierCode);
            var res = await ApiClient.get('CONSIGNMENT', url);
            var data = res.data || res;
            this.populateDropdown(this.selectors.contract, 'Select Contract', data, selectedValue);
        } catch (e) {
            console.error('Failed to load contracts:', e);
        }
    },
    
    // For manual triggering of cascading setup from existing loaded values
    triggerCascade: function() {
        var comp = $(this.selectors.company).val();
        var st = $(this.selectors.store).val();
        var sup = $(this.selectors.supplier).val();
        var con = $(this.selectors.contract).val();
        
        if (comp) this.loadCompanies(comp).then(() => {
            if (st) this.loadStores(comp, st).then(() => {
                if (sup) this.loadSuppliers(comp, st, sup).then(() => {
                    if (con) this.loadContracts(comp, st, sup, con);
                });
            });
        });
    }
};

window.ConsignmentMasterData = ConsignmentMasterData;
