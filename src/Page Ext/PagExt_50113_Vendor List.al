pageextension 50113 "QBA Vendor List" extends "Vendor List"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addafter(PayVendor)
        {
            action(SelectToExportExcel)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Select Invoice To Export Excel';
                Image = SuggestVendorPayments;
                //Visible = false;
                RunObject = Page "QBA Vendor Ledger Entries";
                RunPageLink = //Exported = filter(false),
                              "Remaining Amount" = filter(< 0),
                              "Applies-to ID" = filter(''),
                              "Document Type" = filter(Invoice);
                ToolTip = 'Opens vendor ledger entries for the selected vendor with invoices that have not been paid yet.';
            }
        }
        addafter(PayVendor_Promoted)
        {
            actionref(SelectToExportExcel_Promoted; SelectToExportExcel)
            {
            }
        }
    }

    var
        myInt: Integer;
}