{{ config(
    unique_key = '_payroll_hashid'
) }}

-- Final base SQL model
-- depends_on: {{ ref('payroll_cta2') }}

select
    Company_Code,
    Payroll_Name,
    File_Number,
    Associate_ID,
    Pay_Date,
    Job_Title_Description,
    Home_Department_Code,
    Home_Department_Description,
    Worked_In_Department,
    Worked_In_Department_Description,
    Distribution_Number,
    Gross_Pay_USD,
    Net_Pay_USD,
    Take_Home_USD,
    Regular_Hours_Total,
    Overtime_Hours_Total,
    Additional_Hours_HOL,
    Additional_Hours_SIK,
    Additional_Hours_PTO,
    Additional_Hours_COV,
    Total_Hours,
    Regular_Earnings_Total_USD,
    Overtime_Earnings_Total_USD,
    Additional_Earnings_HOL_USD,
    SIK_SICK_LEAVE_Earnings_USD,
    PTO_Earnings_USD,
    Additional_Earnings_COV_USD,
    _1FA_FF_FMLA_Earnings_USD,
    _1FE_FF_PSL_EE_Earnings_USD,
    _1FF_FF_PSL_FAM_Earnings_USD,
    BN_BONUS_Earnings_USD,
    DEV_Phone_Bonus_Earnings_USD,
    DIB_DRIVER_Earnings_USD,
    PER_PERSONAL_Earnings_USD,
    PPE_PRPD_Earnings_Earnings_USD,
    RF1_REFERRAL_Earnings_USD,
    UPT_UNPAID_TIME_Earnings_USD,
    VAC_VACATION_Earnings_USD,
    Total_Deductions_USD,
    Family_Leave_Insurance_Employee_Tax_USD,
    Federal_Income_Employee_Tax_USD,
    Lived_In_Local_Employee_Tax_USD,
    Lived_In_State_Employee_Tax_USD,
    Local_4_Employee_Tax_USD,
    Local_5_Employee_Tax_USD,
    Medical_Leave_Insurance_Employee_Tax_USD,
    Medicare_Employee_Tax_USD,
    Medicare_Adjust_Employee_Tax_USD,
    Medicare_Surtax_Adjust_Employee_Tax_USD,
    School_District_Employee_Tax_USD,
    SDI_Employee_Tax_USD,
    Social_Security_Employee_Tax_USD,
    SUI_Employee_Tax_USD,
    SUI_SDI_Employee_Tax_USD,
    Transit_Employee_Tax_USD,
    Worked_In_Local_Employee_Tax_USD,
    Worked_In_State_Employee_Tax_USD,
    Workers_Comp_Assessment_Employee_Tax_USD,
    Family_Leave_Insurance_Employer_Tax_USD,
    FUTA_Employer_Tax_USD,
    Lived_in_Local_Employer_Tax_USD,
    Lived_in_State_Employer_Tax_USD,
    Local_4_Employer_Tax_USD,
    Local_5_Employer_Tax_USD,
    Medical_Leave_Insurance_Employer_Tax_USD,
    Medicare_Employer_Tax_USD,
    MTA_Employer_Tax_USD,
    School_District_Employer_Tax_USD,
    SDI_Employer_Tax_USD,
    Social_Security_Employer_Tax_USD,
    SUI_Employer_Tax_USD,
    SUI_SDI_Employer_Tax_USD,
    Transit_Employer_Tax_USD,
    Worked_in_Local_Employer_Tax_USD,
    Worked_in_State_Employer_Tax_USD,
    Workers_Comp_Assessment_Employer_Tax_USD,
    Void_Check_Indicator,
    Check_Voucher_Code,
    Check_Voucher_Number,
    _payroll_hashid,
    _cta_loaded_at
from {{ ref('payroll_cta2') }}
