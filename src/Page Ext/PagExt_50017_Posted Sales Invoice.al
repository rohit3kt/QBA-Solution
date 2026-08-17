pageextension 50017 PostedSalesInvoice extends "Posted Sales Invoice"
{
    layout
    {
        addafter("Work Description")
        {
            field(QRCode11; Rec."QR Code")
            {
                ApplicationArea = All;
            }
        }
        modify("QR Code")
        {
            Visible = true;
        }
    }
    actions
    {
        addafter(Print)
        {
            action(Print2)
            {
                Caption = 'Print Sales Invoice';
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Print;

                trigger OnAction()
                var
                    RecSalesInvHeader: Record "Sales Invoice Header";
                begin
                    RecSalesInvHeader.Reset();
                    RecSalesInvHeader.SetRange("No.", Rec."No.");
                    if RecSalesInvHeader.FindFirst() then
                        Report.run(50034, true, false, RecSalesInvHeader)
                end;
            }
        }
        modify("Import E-Invoice Response")
        {
            Visible = true;
        }
    }
    var

}
