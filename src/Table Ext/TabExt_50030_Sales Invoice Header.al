tableextension 50030 SalInvHeader extends "Sales Invoice Header"
{
    fields
    {
        field(50002; "IEC No."; Code[20])
        {
            Caption = 'IEC No.';
            DataClassification = ToBeClassified;
        }
        field(50003; "Amount (LCY)"; Decimal)
        {
            Caption = 'Amount (LCY)';
            Editable = false;
            DataClassification = CustomerContent;
        }
    }
    var
        PictureUpdated: Record "Detailed Cust. Ledg. Entry";
}
