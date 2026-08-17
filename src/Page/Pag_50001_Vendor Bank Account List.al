page 50001 "QBA Vendor Bank Account List"
{
    ApplicationArea = all;
    Caption = 'Vendor Bank Account List';
    CardPageID = "Vendor Bank Account Card";
    DataCaptionFields = "Vendor No.";
    SourceTable = "Vendor Bank Account";
    UsageCategory = Lists;
    PageType = List;
    Permissions =
        Tabledata Vendor = R,
        Tabledata "Vendor Bank Account" = RIMD;


    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Vendor No."; Rec."Vendor No.")
                {
                    Caption = 'Vendor No.';
                }
                field("Beneficiary ID"; Rec."Beneficiary ID")
                {
                    ApplicationArea = All;
                }
                field("Beneficiary Name"; Rec."Beneficiary Name")
                {
                    Caption = 'Beneficiary Name';
                }
                field(Code; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a code to identify this vendor bank account.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the name of the bank where the vendor has this bank account.';
                }
                field("BankAccount No."; Rec."Bank Account No.")
                {
                    Caption = 'Bank Account No.';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the country/region of the address.';
                }

                field("Bank Branch No."; Rec."Bank Branch No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Bank Clearing Code"; Rec."Bank Clearing Code")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'IFSC Code';
                }
                field("Payment Mode"; Rec."Payment Mode")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = false;
            }
        }
    }
    actions
    {
    }

    var
        //RecVendor: Record Vendor;
        //RecVendorBankAccount: Record "Vendor Bank Account";
        aa: Record "Vendor Ledger Entry";

    trigger OnOpenPage()
    var
        MonitorSensitiveField: Codeunit "Monitor Sensitive Field";
    begin
        MonitorSensitiveField.ShowPromoteMonitorSensitiveFieldNotification();
    end;

    trigger OnAfterGetRecord()
    begin
        // if Rec."Beneficiary Name" = '' then begin
        //     if RecVendor.Get(Rec."Vendor No.") then begin
        //         if RecVendorBankAccount.Get(Rec."Vendor No.", Rec.Code) then begin
        //             RecVendorBankAccount."Beneficiary Name" := RecVendor.Name;
        //             RecVendorBankAccount.Modify();
        //             CurrPage.Update();
        //         end;
        //     end;
        // end;
    end;
}
