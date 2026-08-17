pageextension 50011 SalesInvoice extends "Sales Invoice"
{
    layout
    {
        addafter("Sell-to Customer Name")
        {
            field(PostingNoSeries; Rec."Posting No. Series")
            {
                ApplicationArea = all;
                Caption = 'Posting No. Series';
            }
        }
        addafter("External Document No.")
        {
            field("ShortcutDimension1Code"; Rec."Shortcut Dimension 1 Code")
            {
                caption = 'Business Unit Code';
                ApplicationArea = all;
            }
            field("Shortcut Dimension2Code"; Rec."Shortcut Dimension 2 Code")
            {
                caption = 'Project Code';
                ApplicationArea = all;
            }
        }
        modify("Prices Including VAT")
        {
            CaptionClass = label1;
        }
    }
    actions
    {
        addafter("P&osting")
        {
            action(Print2)
            {
                Caption = 'Print Proforma Invoice';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = all;

                trigger OnAction()
                begin
                    salHeader.reset;
                    salHeader.SetRange("No.", Rec."No.");
                    if salHeader.FindFirst()then Report.Run(50014, true, false, salHeader);
                end;
            }
        }
    }
    var label1: Label 'Price Including GST';
    salHeader: Record 36;
}
