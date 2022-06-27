public class PDFContractFromOppController {
	public Opportunity opportunityRecord { get; set; }
	public List<OpportunityLineItem> products { get; set; }
	public String customer { get; set; }
	public String seller_company { get; set; }
	public Decimal sumOfQuantity { get; set; }
	public Decimal sumOfPrice { get; set; }
	public String labelFrontPageFormattedText { get; set; }

	public PDFContractFromOppController(ApexPages.StandardController controller) {
		opportunityRecord = (Opportunity) controller.getRecord();
		opportunityRecord = [SELECT Id, ContractId FROM Opportunity WHERE Id = :opportunityRecord.Id];
		products = [SELECT Product2Id, Quantity, UnitPrice FROM OpportunityLineItem WHERE OpportunityId = :opportunityRecord.Id];

		if (String.isNotBlank(opportunityRecord.ContractId)) {
			Contract contractRecord = [SELECT CompanySignedId, CustomerSignedId FROM Contract WHERE Id = :opportunityRecord.ContractId];
			if (contract.CustomerSignedId != null || contract.CompanySignedId != null) {
				Contact contractName = [SELECT Name FROM Contact WHERE Id = :contractRecord.CustomerSignedId];
				User userName = [SELECT Name FROM User WHERE Id = :contractRecord.CompanySignedId];
				customer = contractName.Name;
				seller_company = userName.Name;
				labelFrontPageFormattedText = System.Label.pdfFrontPageText.replace('{custmer}', customer).replace('{seller company}', seller_company);
			}
		}

		sumOfQuantity = 0;
		sumOfPrice = 0;
		for (OpportunityLineItem productRecord : products) {
			sumOfQuantity += productRecord.Quantity;
			sumOfPrice += productRecord.UnitPrice;
		}
	}
}
