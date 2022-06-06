public class PDFContractFromOppController {
    public Opportunity opp{get; set;}
    public List<OpportunityLineItem> products{get; set;}
    public String customer{get; set;}
    public String seller_company{get; set;}
    public Decimal sumOfQuantity{get; set;}
    public Decimal sumOfPrice{get; set;}
    public String labelFrontPageFormattedText{get; set;}

	public PDFContractFromOppController(ApexPages.StandardController controller) {
		opp = (Opportunity)controller.getRecord();
        opp = [SELECT Id, ContractId FROM Opportunity WHERE Id =: opp.Id];
        products = [SELECT Product2Id, Quantity, UnitPrice FROM OpportunityLineItem WHERE OpportunityId =: opp.Id];

        if(opp.ContractId != null){
            Contract contract = [SELECT CompanySignedId, CustomerSignedId FROM Contract WHERE Id =: opp.ContractId];
            if(contract.CustomerSignedId != null || contract.CompanySignedId != null){
                Contact ct = [SELECT Name FROM Contact WHERE Id =: contract.CustomerSignedId];
                User usr = [SELECT Name FROM User WHERE Id =: contract.CompanySignedId];
                customer = ct.Name;
                seller_company = usr.Name;
                labelFrontPageFormattedText = System.Label.pdfFrontPageText.replace('{custmer}', customer).replace('{seller company}', seller_company);
            }
        }
        sumOfQuantity = 0;
        sumOfPrice = 0;
        for(OpportunityLineItem p : products){
            sumOfQuantity += p.Quantity;
            sumOfPrice += p.UnitPrice;
        }
	}
}
