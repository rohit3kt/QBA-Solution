page 50003 "Input Box"
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
                field(Comments; Comments)
                {
                    ApplicationArea = All;
                }
                field(CodeComment; CodeComment)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    procedure GetComment(): Date
    begin
        exit(Comments);
    end;

    procedure GetCodeComment(): Code[20]
    begin
        exit(CodeComment);
    end;

    var
        Comments: Date;
        CodeComment: Code[20];
}