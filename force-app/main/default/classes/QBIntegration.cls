public class QBIntegration {
    
     public static void fetchCustomer(String id){
        try{
            String endPointURL= 'callout:qbOnline/v3/company/'+System.Label.QuickbookSandboxId+'/customer/'+id+'?minorversion=65';
            map<string,string> headersMap = new  map<string,string>();
            headersMap.put('Content-Type','application/json'); 
            headersMap.put('Accept', 'application/json');
            HttpResponse res = CalloutController.calloutMethod(endPointURL,'GET',headersMap,'', true, false);
            restResourceJson cust = new restResourceJson();
            cust = (restResourceJson)JSON.deserialize(res.getBody(), restResourceJson.class);

			System.debug('Limits.getCallouts - '+ Limits.getCallouts());
			System.debug('Limits.getLimitCallouts - '+ Limits.getLimitCallouts());            
            List<Account> accountList = [select id, name,ParentId,Customer_Id__c,Website,Phone,ShippingStreet,
                                         ShippingPostalCode,ShippingCountry,ShippingCity,BillingPostalCode,BillingStreet,BillingCountry,
                                         BillingCity,Description from Account where Customer_Id__c = :cust.Customer.id];
            list<Account> testList = new List<Account>();
            Set<Id> accIdSet = new Set<Id>();
            if(cust.Customer.Active==false){
                if(accountList.size()>0){
                    for(account a:accountList){
                        accIdSet.add(a.Id);
                    }
                    List<Opportunity> opList = [Select Id,AccountId from Opportunity where AccountId in :accIdSet];
                    delete opList;
                    delete accountList;
                }
            }else{
                if(accountList.size()<=0){
                    Account acc = new Account();
                    if (cust.Customer != null) {
                        if (cust.Customer.PrintOnCheckName != null) {
                          //  acc.Name_to_print_on_checks__c = cust.Customer.PrintOnCheckName;
                        }
                        if (cust.Customer.FullyQualifiedName != null) {
                            acc.Name = cust.Customer.FullyQualifiedName;
                        }
                        if (cust.Customer.Notes != null) {
                          //  acc.Notes__c = cust.Customer.Notes;
                        }
                        if (cust.Customer.MiddleName != null) {
                         //   acc.Middle_Name__c = cust.Customer.MiddleName;
                        }
                        if (cust.Customer.FamilyName != null) {
                          //  acc.Family_Name__c = cust.Customer.FamilyName;
                        }
                        if (cust.Customer.GivenName != null) {
                           // acc.Given_Name__c = cust.Customer.GivenName;
                        }
                        if (cust.Customer.BillAddr != null) {
                            if (cust.Customer.BillAddr.City != null) {
                                acc.BillingCity = cust.Customer.BillAddr.City;
                            }
                            if (cust.Customer.BillAddr.Country != null) {
                                acc.BillingCountry = cust.Customer.BillAddr.Country;
                            }
                            if (cust.Customer.BillAddr.Line1 != null) {
                                acc.BillingStreet = cust.Customer.BillAddr.Line1;
                            }
                            if (cust.Customer.BillAddr.PostalCode != null) {
                                acc.BillingPostalCode = cust.Customer.BillAddr.PostalCode;
                            }
                        }
                        if (cust.Customer.ShipAddr != null) {
                            if (cust.Customer.ShipAddr.City != null) {
                                acc.ShippingCity = cust.Customer.ShipAddr.City;
                            }
                            if (cust.Customer.ShipAddr.Country != null) {
                                acc.ShippingCountry = cust.Customer.ShipAddr.Country;
                            }
                            if (cust.Customer.ShipAddr.Line1 != null) {
                                acc.ShippingStreet = cust.Customer.ShipAddr.Line1;
                            }
                            if (cust.Customer.ShipAddr.PostalCode != null) {
                                acc.ShippingPostalCode = cust.Customer.ShipAddr.PostalCode;
                            }
                        }
                        if (cust.Customer.PrimaryPhone != null) {
                            if (cust.Customer.PrimaryPhone.FreeFormNumber != null) {
                                acc.Phone = cust.Customer.PrimaryPhone.FreeFormNumber;
                            }
                        }
                        
                        if (cust.Customer.Mobile != null) {
                            if (cust.Customer.Mobile.FreeFormNumber != null) {
                               // acc.Mobile__c = cust.Customer.Mobile.FreeFormNumber;
                            }
                        }
                        
                        if (cust.Customer.ParentRef != null) {
                            if (cust.Customer.ParentRef.value != null) {
                                account acParent = [select id, customer_id__c from account where customer_id__c=:cust.Customer.ParentRef.value ];
                                acc.ParentId = acParent.Id;
                            }
                        }
                        
                        
                        if (cust.Customer.Fax != null) {
                            if (cust.Customer.Fax.FreeFormNumber != null) {
                              //  acc.Fax__c = cust.Customer.Fax.FreeFormNumber;
                            }
                        }
                        if (cust.Customer.PrimaryEmailAddr != null) {
                            if (cust.Customer.PrimaryEmailAddr.Address != null) {
                             //   acc.Primary_Email_Address__c = cust.Customer.PrimaryEmailAddr.Address;
                            }
                        }
                        if (cust.Customer.CompanyName != null) {
                           // acc.Company_Name__c = cust.Customer.CompanyName;
                        }
                        if (cust.Customer.Title != null) {
                           // acc.Title__c = cust.Customer.Title;
                        }
                        
                        if (cust.Customer.Suffix != null) {
                          //  acc.Suffix__c = cust.Customer.Suffix;
                        }
                        
                        if (cust.Customer.WebAddr != null) {
                            if (cust.Customer.WebAddr.URI != null) {
                                acc.Website = cust.Customer.WebAddr.URI;
                            }
                        }
                        acc.Customer_Id__c = cust.Customer.id;
                        
                        try {
                            
                            insert acc;
                        } catch(DmlException e) {
                            System.debug('The following exception has occurred: ' + e.getMessage());
                        }
                        
                    }
                }else {
                    Account account = accountList[0];
                    
                    if (cust != null && cust.Customer != null) {
                        
                        if (cust.Customer.PrintOnCheckName != null) {
                          //  account.Name_to_print_on_checks__c = cust.Customer.PrintOnCheckName;
                        }
                        
                        if (cust.Customer.FullyQualifiedName != null) {
                            account.Name = cust.Customer.FullyQualifiedName;
                        }
                        if (cust.Customer.Notes != null) {
                          //  account.Notes__c = cust.Customer.Notes;
                        }
                        
                        if (cust.Customer.MiddleName != null) {
                            //account.Middle_Name__c = cust.Customer.MiddleName;
                        }
                        
                        if (cust.Customer.FamilyName != null) {
                           // account.Family_Name__c = cust.Customer.FamilyName;
                        }
                        
                        if (cust.Customer.GivenName != null) {
                            //account.Given_Name__c = cust.Customer.GivenName;
                        }
                        
                        if (cust.Customer.BillAddr != null) {
                            if (cust.Customer.BillAddr.City != null) {
                                account.BillingCity = cust.Customer.BillAddr.City;
                            }
                            
                            if (cust.Customer.BillAddr.Country != null) {
                                account.BillingCountry = cust.Customer.BillAddr.Country;
                            }
                            if (cust.Customer.BillAddr.Line1 != null) {
                                account.BillingStreet = cust.Customer.BillAddr.Line1;
                            }
                            if (cust.Customer.BillAddr.PostalCode != null) {
                                account.BillingPostalCode = cust.Customer.BillAddr.PostalCode;
                            }
                        }
                        
                        if (cust.Customer.ShipAddr != null) {
                            if (cust.Customer.ShipAddr.City != null) {
                                account.ShippingCity = cust.Customer.ShipAddr.City;
                            }
                            
                            if (cust.Customer.BillAddr.Country != null) {
                                account.ShippingCountry = cust.Customer.ShipAddr.Country;
                            }
                            
                            if (cust.Customer.BillAddr.PostalCode != null) {
                                account.ShippingPostalCode = cust.Customer.ShipAddr.PostalCode;
                            }
                            
                            if (cust.Customer.BillAddr.Line1 != null) {
                                account.ShippingStreet = cust.Customer.ShipAddr.Line1;
                            }
                        }
                        
                        if (cust.Customer.PrimaryPhone != null && cust.Customer.PrimaryPhone.FreeFormNumber != null) {
                            account.Phone = cust.Customer.PrimaryPhone.FreeFormNumber;
                        }
                        
                        if (cust.Customer.Mobile != null) {
                            if (cust.Customer.Mobile.FreeFormNumber != null) {
                               // account.Mobile__c = cust.Customer.Mobile.FreeFormNumber;
                            }
                        }
                        
                        if (cust.Customer.Fax != null) {
                            if (cust.Customer.Fax.FreeFormNumber != null) {
                               // account.Fax__c = cust.Customer.Fax.FreeFormNumber;
                            }
                        }
                        
                        if (cust.Customer.WebAddr != null) {
                            if (cust.Customer.WebAddr.URI != null) {
                                account.Website = cust.Customer.WebAddr.URI;
                            }
                        }
                        
                        if (cust.Customer.PrimaryEmailAddr != null && cust.Customer.PrimaryEmailAddr.Address != null) {
                           // account.Primary_Email_Address__c = cust.Customer.PrimaryEmailAddr.Address;
                        }
                        
                        if (cust.Customer.CompanyName != null) {
                            //account.Company_Name__c = cust.Customer.CompanyName;
                        }
                        
                        if (cust.Customer.Title != null) {
                           // account.Title__c = cust.Customer.Title;
                        }
                        if (cust.Customer.Suffix != null) {
                           // account.Suffix__c = cust.Customer.Suffix;
                        }
                        
                        if (cust.Customer.ParentRef != null) {
                            if (cust.Customer.ParentRef.value != null) {
                                account acParent = [select id, customer_id__c from account where customer_id__c=:cust.Customer.ParentRef.value ];
                                account.ParentId = acParent.Id;
                            }
                        }
                        
                        testList.add(account);
                    }
                }
            }
            
            
            try {
                
                update testList;
            } catch(DmlException e) {
                System.debug('The following exception has occurred: ' + e.getMessage());
            }
            
            
        }catch(Exception e){
            System.debug('exception '+e);
        }
        
        
        
    }  
    
    @AuraEnabled
    public static boolean createInvoices(String recordId) {
        boolean resultBool=false;
        
        try {
            List<Opportunity> opportunities = [SELECT Id, CloseDate,Name,Account.Name,Opportunity.OwnerId,Tax_Rate__r.Tax_Code_Name__c,
                                               Tax_Rate__r.Tax_Rate_Value__c,Tax_Rate__r.Name,Tax_Rate__r.TaxIdFromQB__c,(SELECT Product2.Name, Quantity, UnitPrice FROM OpportunityLineItems)
                                               FROM Opportunity WHERE Id = :recordId AND StageName = 'Closed Won'];
            if(opportunities.size()>0){
                resultBool=true;
            }else{
                resultBool=false;
            }
            List<Attachment> lstAttachment = new List<Attachment>();
            string testing;
            for (Opportunity opportunity : opportunities) {
                system.debug('inside oppor');
                String customerId = '3';
                invoiceWrapper invoiceObj = new invoiceWrapper();
                invoiceWrapper.TxnTaxDetail TxnTaxDetailobj = new invoiceWrapper.TxnTaxDetail();
                invoicewrapper.TxnTaxCodeRef TxnTaxCodeRefobj = new invoicewrapper.TxnTaxCodeRef();
                
                invoiceObj.Line = new List<invoiceWrapper.Line>();               
                for (OpportunityLineItem oppLineItem : opportunity.OpportunityLineItems) {
                    System.debug('oppLineItem.Product2.Name '+oppLineItem.Product2.Name);
                    String itemId = '3';
                    Decimal amount = oppLineItem.UnitPrice * oppLineItem.Quantity;
                    invoiceWrapper.Line lineItem = new invoiceWrapper.Line();
                    lineItem.Description = oppLineItem.Product2.Name;
                    lineItem.Amount = amount;
                    lineItem.DetailType = 'SalesItemLineDetail';
                    lineItem.SalesItemLineDetail = new invoiceWrapper.SalesItemLineDetail();
                    lineItem.SalesItemLineDetail.ItemRef = new invoiceWrapper.ItemRef();
                    lineItem.SalesItemLineDetail.TaxCodeRef = new invoiceWrapper.TaxCodeRef();
                    lineItem.SalesItemLineDetail.ItemRef.value = itemId;
                    lineItem.SalesItemLineDetail.TaxCodeRef.value = 'TAX';
                    lineItem.SalesItemLineDetail.UnitPrice = oppLineItem.UnitPrice;
                    lineItem.SalesItemLineDetail.Qty = (Integer)oppLineItem.Quantity;
                    invoiceObj.Line.add(lineItem);
                    system.debug('itemId '+itemId);
                    if (itemId == null) {
                        itemId = createItem(oppLineItem);
                    }
                    
                    
                }
                invoiceObj.CustomerRef = new invoiceWrapper.CustomerRef();
                TxnTaxCodeRefobj.name=opportunity.Tax_Rate__r.Name;
                TxnTaxCodeRefobj.value= opportunity.Tax_Rate__r.Tax_Rate_Value__c;
                TxnTaxDetailobj.TxnTaxCodeRef = TxnTaxCodeRefobj;
                invoiceObj.TxnTaxDetail = TxnTaxDetailobj;
                invoiceObj.CustomerRef.value = '3';
                invoiceObj.DueDate= string.valueOf(opportunity.CloseDate);
                String invoiceBody = JSON.serialize(invoiceObj);
                String endPointURL= 'callout:qbOnline/v3/company/'+System.Label.QuickbookSandboxId+'/invoice';
                map<string,string> headersMap = new  map<string,string>();
                headersMap.put('Content-Type','application/json'); 
                headersMap.put('Accept', 'application/json');
                HttpResponse invoiceRes = CalloutController.calloutMethod(endPointURL,'POST',headersMap,invoiceBody, true, true);
                system.debug('inv '+invoicerES.GETBODY());
                Map<String,Object> mapOfInvoice = (Map<String,Object>)Json.deserializeUntyped(invoiceRes.getBody());
                Map<String,Object> mapOfInvoiceForId = (Map<String,Object>)mapOfInvoice.get('Invoice');
                string idOfInvoice = String.valueOf(mapOfInvoiceForId.get('Id'));
                Decimal totalAmt = (Decimal) mapOfInvoiceForId.get('TotalAmt');
                Object totalTax = ((Map<String, Object>) mapOfInvoiceForId.get('TxnTaxDetail')).get('TotalTax');
                
               
                double totalTaxInDecimal = double.valueOf(totalTax);
                decimal amt = totalAmt-totalTaxInDecimal;
                decimal percentage = (totalTaxInDecimal / amt) * 100;
                Decimal formattedDecimal = percentage.setScale(2, RoundingMode.HALF_UP); 
                system.debug('invoiceSendBody '+invoiceBody);
                system.debug('invoiceRes '+invoiceRes.getBody());
                PageReference pageRef = Page.Qty_Pdf;
                pageRef.getParameters().put('recordId',recordId);
                pageRef.getParameters().put('formattedDecimal',String.valueOf(formattedDecimal));
                Blob pdfBlob = pageRef.getContentAsPDF();
                Attachment attachment1 = new Attachment();
                attachment1.Body = pdfBlob;
                attachment1.Name = 'ADET Invoice';
                attachment1.ContentType = 'application/pdf';
                attachment1.ParentId = recordId;
                insert attachment1;
               
                    Messaging.EmailFileAttachment attachmentNew = new Messaging.EmailFileAttachment();
                attachmentNew.setFileName('INVOICE');
                attachmentNew.setBody(pageRef.getContentAsPDF());
                Messaging.EmailFileAttachment[] attachments = new Messaging.EmailFileAttachment[] { attachmentNew };    
                    Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                String[] toAddresses = new String[]{'dashrath@cyntexa.com'};
                    email.setToAddresses(toAddresses);
                email.setSubject('Invoice Generation');
                String emailBody = 'Dear ' + opportunities[0].Name + ',\n\n'
                    + 'I hope this email finds you well. I am writing to kindly request payment for the services provided to ' 
                    + opportunities[0].Account.Name + '.\n\n'
                    + 'I have attached the invoice for your review. Please take the time to carefully review the attached invoice and let me know if you have any questions or concerns. I would be more than happy to discuss any issues you may have and work together to find a solution.\n\n'
                    + 'Thank you for your prompt attention to this matter. I appreciate your business and look forward to continuing our relationship.\n\n'
                    + 'Best regards,\n'
                    + 'ADET IT';
                
                email.setPlainTextBody(emailBody);
                email.setFileAttachments(attachments);
                Messaging.SendEmailResult[] results = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
                
                

            }
            
            try{
                
                return resultBool;
            }catch(DMLException e){
                
                system.debug('exception '+ e.getMessage());
                return resultBool;
            }
            
            
            
        } catch (Exception e) {
            System.debug('in catch--> ' + e.getLineNumber()+ ' message '+e.getMessage());
            System.debug(e);
            return resultBool;
        }
    }
    
    
    public static String getItemId(String productName) {
        try{
            map<string,string> headersMap = new  map<string,string>();
            headersMap.put('Content-Type','application/json'); 
                        //headersMap.put('Content-Type','application/json'); 
            String query = 'SELECT Id FROM Item WHERE Name =\'' + productName.replace('\'', '\\\'') + '\'';
            String endPointURL= 'callout:qbOnline/v3/company/'+System.Label.QuickbookSandboxId+'/query?query=' + EncodingUtil.urlEncode(query, 'UTF-8') + '&minorversion=65';
            HttpResponse itemCheckRes = CalloutController.calloutMethod(endPointURL,'GET',headersMap,'', true, false);
             system.debug('itemCheckRes '+itemCheckRes.getStatusCode());
            if (itemCheckRes.getStatusCode() == 200) {
                XmlStreamReader reader = new XmlStreamReader(itemCheckRes.getBody());
                while (reader.hasNext()) {
                    if (reader.getEventType() == XmlTag.START_ELEMENT && reader.getLocalName() == 'Id') {
                        reader.next();
                        return reader.getText();
                    }
                    reader.next();
                }
            }
            return null;
        }catch(Exception e){
            system.debug('exception ' +e);
            return string.valueOf(e);
        }
        
    }
    
    public static String createItem(OpportunityLineItem oppLineItem) {
        try{
            String endPointURL= 'callout:qbOnline/v3/company/'+System.Label.QuickbookSandboxId+'/item?minorversion=40';
            map<string,string> headersMap = new  map<string,string>();
            headersMap.put('Content-Type','application/json'); 
            headersMap.put('Accept', 'application/json');
            itemJson itemObj = new itemJson();
            
            itemJson.IncomeAccountRef icf = new itemJson.IncomeAccountRef();
            icf.value ='79';
            itemObj.IncomeAccountRef=icf;
            
            itemJson.AssetAccountRef acf = new itemJson.AssetAccountRef();
            acf.value = '81';
            itemObj.AssetAccountRef=acf;
            
            itemJson.ExpenseAccountRef ecf = new itemJson.ExpenseAccountRef();
            ecf.value = '80';
            itemObj.ExpenseAccountRef=ecf;
            
            itemObj.Name=oppLineItem.Product2.Name;
            itemObj.Type='Inventory';
            itemObj.TrackQtyOnHand=true;
            itemObj.QtyOnHand=(Integer)oppLineItem.Quantity;
            itemObj.InvStartDate='2023-01-01';
            String itemBody = Json.serialize(itemObj);
            HttpResponse itemRes = CalloutController.calloutMethod(endPointURL,'POST',headersMap,itemBody, true, true);
            system.debug('itemCreateRes '+itemRes.getBody());
            String itemId = '';
            if (itemRes.getStatusCode() == 200) {
                Map<String,Object> mapOfItem = (Map<String,Object>)Json.deserializeUntyped(itemRes.getBody());
                Map<String,Object> mapOfItemForId = (Map<String,Object>)mapOfItem.get('Item');
                itemId = String.valueOf(mapOfItemForId.get('Id'));
                
            }     
            return itemId;
        }catch(Exception e){
            system.debug('excp '+string.valueOf(e));
            return string.valueOf(e);
        }
        
    }
    
    @future(callout=true)
    public static void taxDetails(string jsonData){
        Tax_Rate__c tax = (Tax_Rate__c)JSON.deserialize(jsonData, Tax_Rate__c.class);
        taxInfoWrapper wrapper = new taxInfoWrapper();
        wrapper.TaxCode = tax.Tax_Code_Name__c;
        
        taxInfoWrapper.cls_TaxRateDetails taxRateDetails = new taxInfoWrapper.cls_TaxRateDetails();
        taxRateDetails.RateValue = tax.Tax_Rate_Value__c;
        taxRateDetails.TaxApplicableOn = 'Sales';
        taxRateDetails.TaxAgencyId = '1';
        taxRateDetails.TaxRateName = tax.Name;
        
        wrapper.TaxRateDetails = new List<taxInfoWrapper.cls_TaxRateDetails>();
        wrapper.TaxRateDetails.add(taxRateDetails);
        String jsonDataTax = JSON.serialize(wrapper);
        //  System.debug('jsonData ' + json);
        String endPointURL = 'callout:qbOnline/v3/company/'+System.Label.QuickbookSandboxId+'/taxservice/taxcode?minorversion=65';
        system.debug('endPointUrl '+endPointURL);
        Map<String, String> headersMap = new Map<String, String>();
        headersMap.put('Content-Type', 'application/json'); 
        headersMap.put('Accept', 'application/json');
        HttpResponse resTax = CalloutController.calloutMethod(endPointURL, 'POST', headersMap, jsonDataTax, true, true);
        system.debug('res '+resTax.getBody());
        TaxRateResponse response = (TaxRateResponse) JSON.deserialize(resTax.getBody(), TaxRateResponse.class);
        String taxRateId = response.TaxRateDetails[0].TaxRateId;
        System.debug('TaxRateId: ' + taxRateId);
        tax.TaxIdFromQB__c=taxRateId;
        update tax;
        
        
    }
   
    public static void checkDuplicateDisplayName(List<Account> accountsToInsert) {
        Set<String> existingDisplayNames = new Set<String>();
        for (Account acc : [SELECT Name FROM Account]) {
            existingDisplayNames.add(acc.Name);
        }
        for (Account acc : accountsToInsert) {
            if (existingDisplayNames.contains(acc.Name)) {
                acc.addError('An account with this name already exists.');
            }
        }
        
    }
    
  
    
}