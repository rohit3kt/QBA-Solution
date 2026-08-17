// report 50039 "QBA Delet GST Ledger Entry"
// {
//     UsageCategory = ReportsAndAnalysis;
//     ApplicationArea = All;
//     ProcessingOnly = true;
//     Permissions = tabledata "G/L Entry" = RIMD;

//     dataset
//     {
//         dataitem(Integer; Integer)
//         {
//             DataItemTableView = sorting(Number)
//                                 where(Number = const(1));
//             trigger OnPreDataItem()
//             begin
//                 if not InsertAllowed then
//                     Error('You do not have permission to delete records... Please Enable Delete Allowed Boolean');
//             end;

//             trigger OnAfterGetRecord()
//             var
//                 Temptime: Time;
//             begin
//                 GLEntry.Init();
//                 GLEntry."Entry No." := 1;
//                 GLEntry.Amount := 40610.6;
//                 GLEntry."Bal. Account Type" := GLEntry."Bal. Account Type"::"G/L Account";
//                 GLEntry."Debit Amount" := 40610.6;
//                 GLEntry.Description := 'Order SOR/24-25/0006';
//                 GLEntry."Dimension Set ID" := 78;
//                 GLEntry."Document Date" := 20240416D;
//                 GLEntry."Document No." := 'QBA/24-25/001';
//                 GLEntry."Document Type" := GLEntry."Document Type"::Invoice;
//                 GLEntry."External Document No." := 'AMVIPL/SERVICES/2024/016';
//                 GLEntry."G/L Account Name" := 'IndExp Discount Allowed';
//                 GLEntry."G/L Account No." := '826600';
//                 GLEntry."Gen. Bus. Posting Group" := 'DOMESTIC';
//                 GLEntry."Gen. Posting Type" := GLEntry."Gen. Posting Type"::Sale;
//                 GLEntry."Gen. Prod. Posting Group" := 'IT_INR_B';
//                 GLEntry."Global Dimension 1 Code" := 'QBA_KOL';
//                 GLEntry."Global Dimension 2 Code" := 'AMVIPL-IN-11-149';
//                 GLEntry."No. Series" := 'S-INV+_DOM';
//                 GLEntry."Posting Date" := 20240416D;
//                 GLEntry."Prior-Year Entry" := false;
//                 GLEntry."Source Code" := 'SALES';
//                 GLEntry."Source Currency Amount" := 40610.6;
//                 GLEntry."Source No." := 'C00002';
//                 GLEntry."Source Type" := GLEntry."Source Type"::Customer;
//                 GLEntry."System-Created Entry" := true;
//                 GLEntry."Transaction No." := 1;
//                 GLEntry."User ID" := 'ANINDYA.SEN';
//                 GLEntry."VAT Reporting Date" := 20240416D;

//                 GLEntry1.Get(2);
//                 GLEntry.SystemCreatedAt := GLEntry1.SystemCreatedAt;
//                 GLEntry.SystemCreatedBy := GLEntry1.SystemCreatedBy;
//                 GLEntry.SystemModifiedAt := GLEntry1.SystemModifiedAt;
//                 GLEntry.SystemModifiedBy := GLEntry1.SystemModifiedBy;
//                 GLEntry."Last Modified DateTime" := GLEntry1."Last Modified DateTime";
//                 GLEntry.Insert();
//             end;
//         }
//     }

//     requestpage
//     {
//         AboutTitle = 'Teaching tip title';
//         AboutText = 'Teaching tip content';
//         layout
//         {
//             area(Content)
//             {
//                 group(GroupName)
//                 {
//                     field(InsertAllowed; InsertAllowed)
//                     {
//                         ApplicationArea = All;
//                         Caption = 'Insert Allowed';
//                     }
//                 }
//             }
//         }

//         // actions
//         // {
//         //     area(processing)
//         //     {
//         //         action(LayoutName)
//         //         {

//         //         }
//         //     }
//         // }
//     }

//     // rendering
//     // {
//     //     layout(LayoutName)
//     //     {
//     //         Type = Excel;
//     //         LayoutFile = 'mySpreadsheet.xlsx';
//     //     }
//     // }

//     var
//         myInt: Integer;
//         Count1: Integer;
//         InsertAllowed: Boolean;
//         GLEntry: Record "G/L Entry";

//         GLEntry1: Record "G/L Entry";

// }