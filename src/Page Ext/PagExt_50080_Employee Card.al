pageextension 50080 EmployeeCard extends "Employee Card"
{
    layout
    {
        modify("Union Membership No.")
        {
            Caption = 'UAN No.';
        }
        modify("Social Security No.")
        {
            Caption = 'PAN No.';
        }
        modify(IBAN)
        {
            Caption = 'IFSC Code';
        }
        modify("Bank Branch No.")
        {
            Caption = 'Bank Branch Name';
        }
    }
}
