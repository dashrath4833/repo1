public class TaxRateResponse {
    public String TaxCode;
    public String TaxCodeId;
    public List<TaxRateDetails> TaxRateDetails;

    public class TaxRateDetails {
        public String TaxRateName;
        public String TaxRateId;
        public Decimal RateValue;
        public String TaxAgencyId;
        public String TaxApplicableOn;
    }
}