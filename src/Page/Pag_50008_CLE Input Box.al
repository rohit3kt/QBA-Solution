page 50008 "CLE Input Box"
{
    PageType = StandardDialog;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(EntryNo; EntryNo)
                {
                    Caption = 'Entry No.';
                    ApplicationArea = All;
                }
                field(CustomerNo; CustomerNo)
                {
                    Caption = 'Customer No.';
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }
    procedure GetEntryNo(): Integer
    begin
        exit(EntryNo);
    end;

    procedure GetCustomerNo(): Code[20]
    begin
        exit(CustomerNo);
    end;

    var
        EntryNo: Integer;
        CustomerNo: Code[20];
        aDA: Page "Sales Order Planning";
        aada: page 300;
        adaa:Record 5476;
        dada:Record "Buffer IC Inbox Sales Header";
        adad:Record "Sales Order Entity Buffer";
        asdf:Record "Sales Invoice Line Aggregate";
        PurchLine:Record "Buffer IC Inbox Purchase Line";
        PurchHeader:Record "Buffer IC Inbox Purch Header";
        sassa:Record 5496;
}