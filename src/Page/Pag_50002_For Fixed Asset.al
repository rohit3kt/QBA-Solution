page 50002 "For Fixed Asset"
{
    ApplicationArea = All;
    Caption = 'for fixed asset';
    PageType = List;
    SourceTable = "Fixed Asset";
    UsageCategory = Lists;
    Permissions =
        tabledata "Fixed Asset" = RIMD;

    layout
    {
        area(content)
        {
            repeater(General)
            {
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(uploadfixedasset)
            {
                Caption = 'Upload Fixed Asset';
                Promoted = true;
                PromotedIsBig = true;

                // RunObject= xmlport;
                trigger OnAction()
                begin
                    Xmlport.Run(50000, true, false, Rec);
                end;
            }
        }
    }
}
