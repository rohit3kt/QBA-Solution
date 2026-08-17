report 50006 "Update Vendor"
{
    ApplicationArea = All;
    Caption = 'Update Vendor';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            trigger OnPostDataItem()
            begin
            end;
            trigger OnAfterGetRecord()
            begin
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
}
