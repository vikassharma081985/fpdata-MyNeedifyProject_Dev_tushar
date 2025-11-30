using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public class Supplier:IDisposable
    {
        public Int32 SupplierID { get; set; }
        public string SupplierName { get; set; }
        public string SupplierNameAHLL { get; set; }
        public string SupplierCode { get; set; }
        public string SupplierType { get; set; }
        public string SupplierCategory { get; set; }
        public string OrganizationType { get; set; }
        public string HouseNo { get; set; }
        public string Street { get; set; }
        public string Country { get; set; }
        public string State { get; set; }
        public string City { get; set; }
        public string PinCode { get; set; }
        public string Landline { get; set; }
        public string FaxNo { get; set; }
        public string EmailId { get; set; }
        public string Website { get; set; }
        public string PrimaryContactPerson { get; set; }
        public string PrimaryContactPersonDesignation { get; set; }
        public string PrimaryContactPersonMobileNo { get; set; }
        public string PrimaryContactPersonEmailId { get; set; }
        public string SecondaryContactPerson { get; set; }
        public string SecondaryContactPersonDesignation { get; set; }
        public string SecondaryContactPersonMobileNo { get; set; }
        public string SecondaryContactPersonEmailId { get; set; }
        public string CINNo { get; set; }
        public string PFRegistartionNo { get; set; }
        public string NameonPANCard { get; set; }
        public string PANCardNo { get; set; }
        public string ROCNo { get; set; }
        public string ESIRegistrationNo { get; set; }
        public string ISOCertificationNo { get; set; }
        public string ISOValidUpto { get; set; }
        public string PollutioncontrolBoardCertificationNo { get; set; }
        public string PollutionValidUpto { get; set; }
        public string Bank1 { get; set; }
        public string Bank1Branch { get; set; }
        public string Bank1AccountsNo { get; set; }
        public string Bank1IFSCCode { get; set; }
        public string Bank1Address1 { get; set; }
        public string Bank1Address2 { get; set; }
        public string Bank1City { get; set; }
        public string Bank1State { get; set; }
        public string Bank2 { get; set; }
        public string Bank2Branch { get; set; }
        public string Bank2AccountsNo { get; set; }
        public string Bank2IFSCCode { get; set; }
        public string Bank2Address1 { get; set; }
        public string Bank2Address2 { get; set; }
        public string Bank2City { get; set; }
        public string Bank2State { get; set; }
        public string PaymentTerms { get; set; }
        public string Taxes { get; set; }
        public string DeliveryTerms { get; set; }
        public string VendorToNotes { get; set; }
        public string CreditLimit { get; set; }
        public bool IsActive { get; set; }
        public DateTime CreaterDateTime { get; set; }
        public Int32 CreaterID { get; set; }
        public DateTime UpdateDate { get; set; }
        public Int32 UpdatedBy { get; set; }
        public DateTime CheckedDate { get; set; }
        public Int32 CheckedBy { get; set; }
        public DateTime ApprovedDate { get; set; }
        public Int32 ApprovedBy { get; set; }
        public bool ApprovalStatus { get; set; }
        public string LoginPassword { get; set; }
        public bool IsLoginRequired { get; set; }
        public string LoginUserName { get; set; }
        public bool IsAutoRejectPO { get; set; }
        public bool AutoRejectPOAfterDays { get; set; }
        public bool IsMSMERegistration { get; set; }
        public string MSMERegistrationNo { get; set; }
        public DateTime MSMERegistrationValidDate { get; set; }

        public string FinancialDetails { get; set; }
        public string GstDetails { get; set; }

        public int ItemCategory { get; set; }
        public int ItemSubCategory { get; set; }

        public void Dispose()
        {
            GC.SuppressFinalize(this);
        }
        public void Dispose(bool disposable)
        {
            //GC.SuppressFinalize(this);
        }
    }
}
