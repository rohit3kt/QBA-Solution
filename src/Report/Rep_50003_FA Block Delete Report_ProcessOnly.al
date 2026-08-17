report 50003 "FA Block Delete Report"
{
    Caption = 'FA Block Delete Report';
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(fablock;"Fixed Asset Block")
        {
            RequestFilterFields = Code;

            trigger OnAfterGetRecord()
            begin
            // recFAblock.Reset();
            // recFAblock.SetFilter(Code, 'BLOCK 01');
            // if recFAblock.FindFirst() then begin
            // recFAblock.Get('BLOCK 01');
            // recFAblock.Validate(recFAblock."FA Class Code", 'TANGIBLE');
            //fablock.DeleteAll(true);
            // Message(recFAblock."FA Class Code");
            end;
        // end;
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
    var recFAblock: Record 18632;
}
