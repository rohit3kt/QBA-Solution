

page 50004 "QBA Posted Sales Invoices"
{
    AdditionalSearchTerms = 'posted bill';
    ApplicationArea = Basic, Suite;
    Caption = 'QBA Posted Sales Invoices List';
    CardPageID = "Posted Sales Invoice";
    Editable = false;
    PageType = List;
    QueryCategory = 'Posted Sales Invoices';
    SourceTable = "Sales Invoice Header";
    SourceTableView = sorting("Posting Date")
                      order(descending);
    UsageCategory = History;

    AboutTitle = 'About posted sales invoices';
    AboutText = 'When sales invoices are posted, they appear here where you can follow the remaining amounts to be paid by your customers.';

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    AboutTitle = 'The final invoice number (No.)';
                    AboutText = 'This is the invoice number uniquely identifying each posted sale. Your customers see this number on the invoices they receive from you.';
                    ToolTip = 'Specifies the posted sales invoice number. Each posted sales invoice gets a unique number. Typically, the number is generated based on a number series.';
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customer No.';
                    ToolTip = 'Specifies the number of the customer the invoice concerns.';
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customer Name';
                    ToolTip = 'Specifies the name of the customer that you shipped the items on the invoice to.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the date when the invoice was posted.';
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies when items on the document are shipped or were shipped. A shipment date is usually calculated from a requested delivery date plus lead time.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the currency code of the invoice.';
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the date on which the invoice is due for payment.';
                }

            }
        }

    }
    actions
    {
        area(Processing)
        {
            action(CreateEntry)
            {
                Caption = 'Create CLE';
                ApplicationArea = All;
                Image = Create;
                Visible = false;// This Code Noit Require we Can delet this Action
                trigger OnAction()
                var
                    EventSub: Codeunit "QBA Event Subscriber";
                    InputBox: Page "CLE Input Box";
                    TempEntryNo: Integer;
                    TempCustomerNo: Code[20];
                    Customer: Record "Customer";
                begin
                    InputBox.LookupMode := true;
                    if InputBox.RunModal() <> Action::LookupOK then
                        Error('Process has been aborted!');
                    TempEntryNo := InputBox.GetEntryNo();
                    TempCustomerNo := InputBox.GetCustomerNo();
                    if Customer.Get(TempCustomerNo) then
                        if EventSub.CreateCLE(TempEntryNo, TempCustomerNo) then
                            Message('CLE has been created successfully!')
                        else
                            Error('CLE creation failed!');

                end;
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process', Comment = 'Generated from the PromotedActionCategories property index 1.';
                actionref(CreateEntry_Promoted; CreateEntry)
                {
                }
            }
        }
    }
    var
        DocExchStatusStyle: Text;

    [IntegrationEvent(true, false)]
    local procedure OnOpenPageOnAfterSetFilters(var SalesInvoiceHeader: Record "Sales Invoice Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCreateCreditMemoOnAction(var SalesInvoiceHeader: Record "Sales Invoice Header"; var IsHandled: Boolean)
    begin
    end;
}

