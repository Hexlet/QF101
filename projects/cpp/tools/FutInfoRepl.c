#pragma pack(push, 4)

// Scheme "scheme" description

    struct delivery_report
    {
        signed long long replID; // i8
        signed long long replRev; // i8
        signed long long replAct; // i8
        struct cg_time_t date; // t
        char client_code[8]; // c7
        char type[3]; // c2
        signed int isin_id; // i4
        signed int pos; // i4
        signed int pos_excl; // i4
        signed int pos_unexec; // i4
        signed char unexec; // i1
        char settl_pair[13]; // c12
        char asset_code[26]; // c25
        char issue_code[26]; // c25
        char oblig_rur[10]; // d16.2
        signed int oblig_uni; // i4
        signed long long oblig_qty; // i8
        char fulfil_rur[10]; // d16.2
        signed int fulfil_uni; // i4
        signed long long fulfil_qty; // i8
        signed int step; // i4
        signed int sess_id; // i4
        signed int id_gen; // i4
        
    };
    const int delivery_report_index = 0;


    struct fut_rejected_orders
    {
        signed long long replID; // i8
        signed long long replRev; // i8
        signed long long replAct; // i8
        signed long long order_id; // i8
        signed int sess_id; // i4
        char client_code[8]; // c7
        struct cg_time_t moment; // t
        struct cg_time_t moment_reject; // t
        signed int isin_id; // i4
        signed char dir; // i1
        signed int amount; // i4
        char price[11]; // d16.5
        struct cg_time_t date_exp; // t
        signed long long id_ord1; // i8
        signed int ret_code; // i4
        char ret_message[256]; // c255
        char comment[21]; // c20
        char login_from[21]; // c20
        signed int ext_id; // i4
        
    };
    const int fut_rejected_orders_index = 1;


    struct fut_intercl_info
    {
        signed long long replID; // i8
        signed long long replRev; // i8
        signed long long replAct; // i8
        signed int isin_id; // i4
        char client_code[8]; // c7
        char vm_intercl[10]; // d16.2
        
    };
    const int fut_intercl_info_index = 2;


    struct fut_bond_registry
    {
        signed long long replID; // i8
        signed long long replRev; // i8
        signed long long replAct; // i8
        signed int bond_id; // i4
        char small_name[26]; // c25
        char short_isin[26]; // c25
        char name[76]; // c75
        struct cg_time_t date_redempt; // t
        char nominal[11]; // d16.5
        signed char bond_type; // i1
        signed short year_base; // i2
        
    };
    const int fut_bond_registry_index = 3;


    struct fut_bond_isin
    {
        signed long long replID; // i8
        signed long long replRev; // i8
        signed long long replAct; // i8
        signed int isin_id; // i4
        signed int bond_id; // i4
        char coeff_conversion[5]; // d5.4
        
    };
    const int fut_bond_isin_index = 4;


    struct fut_bond_nkd
    {
        signed long long replID; // i8
        signed long long replRev; // i8
        signed long long replAct; // i8
        signed int bond_id; // i4
        struct cg_time_t date; // t
        char nkd[11]; // d16.7
        signed char is_cupon; // i1
        
    };
    const int fut_bond_nkd_index = 5;


    struct fut_bond_nominal
    {
        signed long long replID; // i8
        signed long long replRev; // i8
        signed long long replAct; // i8
        signed int bond_id; // i4
        struct cg_time_t date; // t
        char nominal[11]; // d16.5
        
    };
    const int fut_bond_nominal_index = 6;


    struct fut_ts_cons
    {
        signed long long replID; // i8
        signed long long replRev; // i8
        signed long long replAct; // i8
        char code_ts[3]; // c2
        struct cg_time_t date_last_clear; // t
        struct cg_time_t date_last_open_day; // t
        
    };
    const int fut_ts_cons_index = 7;


    struct usd_online
    {
        signed long long replID; // i8
        signed long long replRev; // i8
        signed long long replAct; // i8
        signed long long id; // i8
        char rate[10]; // d16.4
        struct cg_time_t moment; // t
        
    };
    const int usd_online_index = 8;


    struct fut_vcb
    {
        signed long long replID; // i8
        signed long long replRev; // i8
        signed long long replAct; // i8
        char code_vcb[26]; // c25
        char name[76]; // c75
        char exec_type[2]; // c1
        char curr[4]; // c3
        char exch_pay[10]; // d16.2
        signed char exch_pay_scalped; // i1
        char clear_pay[10]; // d16.2
        signed char clear_pay_scalped; // i1
        char sell_fee[6]; // d7.3
        char buy_fee[6]; // d7.3
        char trade_scheme[2]; // c1
        char section[51]; // c50
        char exch_pay_spot[11]; // d16.5
        char client_code[8]; // c7
        char exch_pay_spot_repo[11]; // d16.5
        signed int rate_id; // i4
        
    };
    const int fut_vcb_index = 9;


    struct session
    {
        signed long long replID; // i8
        signed long long replRev; // i8
        signed long long replAct; // i8
        signed int sess_id; // i4
        struct cg_time_t begin; // t
        struct cg_time_t end; // t
        signed int state; // i4
        signed int opt_sess_id; // i4
        struct cg_time_t inter_cl_begin; // t
        struct cg_time_t inter_cl_end; // t
        signed int inter_cl_state; // i4
        signed char eve_on; // i1
        struct cg_time_t eve_begin; // t
        struct cg_time_t eve_end; // t
        signed char mon_on; // i1
        struct cg_time_t mon_begin; // t
        struct cg_time_t mon_end; // t
        signed char cleared; // i1
        struct cg_time_t pos_transfer_begin; // t
        struct cg_time_t pos_transfer_end; // t
        
    };
    const int session_index = 10;


    struct multileg_dict
    {
        signed long long replID; // i8
        signed long long replRev; // i8
        signed long long replAct; // i8
        signed int sess_id; // i4
        signed int isin_id; // i4
        signed int isin_id_leg; // i4
        signed int qty_ratio; // i4
        
    };
    const int multileg_dict_index = 11;


    struct trade_modes
    {
        signed long long replID; // i8
        signed long long replRev; // i8
        signed long long replAct; // i8
        signed int trade_mode_id; // i4
        signed int status; // i4
        
    };
    const int trade_modes_index = 12;


    struct fut_sess_contents
    {
        signed long long replID; // i8
        signed long long replRev; // i8
        signed long long replAct; // i8
        signed int sess_id; // i4
        signed int isin_id; // i4
        char short_isin[26]; // c25
        char isin[26]; // c25
        char name[76]; // c75
        signed int inst_term; // i4
        char code_vcb[26]; // c25
        signed char is_limited; // i1
        char limit_up[11]; // d16.5
        char limit_down[11]; // d16.5
        char old_kotir[11]; // d16.5
        char buy_deposit[10]; // d16.2
        char sell_deposit[10]; // d16.2
        signed int roundto; // i4
        char min_step[11]; // d16.5
        signed int lot_volume; // i4
        char step_price[11]; // d16.5
        struct cg_time_t d_pg; // t
        signed char is_spread; // i1
        char coeff[7]; // d9.6
        struct cg_time_t d_exp; // t
        signed char is_percent; // i1
        char percent_rate[5]; // d6.2
        char last_cl_quote[11]; // d16.5
        signed int signs; // i4
        signed char is_trade_evening; // i1
        signed int ticker; // i4
        signed int state; // i4
        signed char vm_calc_type; // i1
        char old_step_price[11]; // d16.5
        char volat_min[13]; // d20.15
        char volat_max[13]; // d20.15
        signed int isin_id_rd; // i4
        signed int isin_id_rb; // i4
        signed char price_dir; // i1
        signed int multileg_type; // i4
        signed int legs_qty; // i4
        char step_price_clr[11]; // d16.5
        char step_price_interclr[11]; // d16.5
        char min_step_curr[11]; // d16.5
        char step_price_curr[11]; // d16.5
        signed int sort_order; // i4
        struct cg_time_t d_start; // t
        char exch_pay[11]; // d16.5
        
    };
    const int fut_sess_contents_index = 13;


    struct fut_instruments
    {
        signed long long replID; // i8
        signed long long replRev; // i8
        signed long long replAct; // i8
        signed int isin_id; // i4
        char short_isin[26]; // c25
        char isin[26]; // c25
        char name[76]; // c75
        signed int inst_term; // i4
        char code_vcb[26]; // c25
        signed char is_limited; // i1
        char old_kotir[11]; // d16.5
        signed int roundto; // i4
        char min_step[11]; // d16.5
        signed int lot_volume; // i4
        char step_price[11]; // d16.5
        struct cg_time_t d_pg; // t
        signed char is_spread; // i1
        char coeff[7]; // d9.6
        struct cg_time_t d_exp; // t
        signed char is_percent; // i1
        char percent_rate[5]; // d6.2
        char last_cl_quote[11]; // d16.5
        signed int signs; // i4
        signed char vm_calc_type; // i1
        char old_step_price[11]; // d16.5
        char volat_min[13]; // d20.15
        char volat_max[13]; // d20.15
        signed char price_dir; // i1
        signed int multileg_type; // i4
        signed int legs_qty; // i4
        char step_price_clr[11]; // d16.5
        char step_price_interclr[11]; // d16.5
        char min_step_curr[11]; // d16.5
        char step_price_curr[11]; // d16.5
        struct cg_time_t d_start; // t
        
    };
    const int fut_instruments_index = 14;


    struct diler
    {
        signed long long replID; // i8
        signed long long replRev; // i8
        signed long long replAct; // i8
        char client_code[8]; // c7
        char name[201]; // c200
        char rts_code[51]; // c50
        char transfer_code[8]; // c7
        signed int status; // i4
        signed int signs; // i4
        
    };
    const int diler_index = 15;


    struct investr
    {
        signed long long replID; // i8
        signed long long replRev; // i8
        signed long long replAct; // i8
        char client_code[8]; // c7
        char name[201]; // c200
        signed int status; // i4
        
    };
    const int investr_index = 16;


    struct fut_sess_settl
    {
        signed long long replID; // i8
        signed long long replRev; // i8
        signed long long replAct; // i8
        signed int sess_id; // i4
        struct cg_time_t date_clr; // t
        char isin[26]; // c25
        signed int isin_id; // i4
        char settl_price[11]; // d16.5
        
    };
    const int fut_sess_settl_index = 17;


    struct sys_messages
    {
        signed long long replID; // i8
        signed long long replRev; // i8
        signed long long replAct; // i8
        signed int msg_id; // i4
        struct cg_time_t moment; // t
        char lang_code[9]; // c8
        signed char urgency; // i1
        signed char status; // i1
        char text[256]; // c255
        struct cg_time_t cancel_moment; // t
        
    };
    const int sys_messages_index = 18;


    struct trf_accounts
    {
        signed long long replID; // i8
        signed long long replRev; // i8
        signed long long replAct; // i8
        char client_code[8]; // c7
        char name[201]; // c200
        char tn_account[35]; // c34
        char bank[201]; // c200
        char corr_account[35]; // c34
        char bic[21]; // c20
        char vatin[51]; // c50
        signed char is_multicode; // i1
        
    };
    const int trf_accounts_index = 19;


    struct money_transfers
    {
        signed long long replID; // i8
        signed long long replRev; // i8
        signed long long replAct; // i8
        signed int id; // i4
        char client_code[8]; // c7
        char amount[10]; // d16.2
        struct cg_time_t moment; // t
        signed int state; // i4
        struct cg_time_t moment_accepted; // t
        char rcv_name[201]; // c200
        char tn_account[21]; // c20
        char bank[201]; // c200
        char corr_account[21]; // c20
        char bic[21]; // c20
        char vatin[13]; // c12
        signed int sess_id; // i4
        signed char type; // i1
        
    };
    const int money_transfers_index = 20;


    struct trf_accounts_map
    {
        signed long long replID; // i8
        signed long long replRev; // i8
        signed long long replAct; // i8
        char client_code[8]; // c7
        char tn_account[35]; // c34
        
    };
    const int trf_accounts_map_index = 21;


    struct RF
    {
        signed long long replID; // i8
        signed long long replRev; // i8
        signed long long replAct; // i8
        char code[3]; // c2
        signed int op_input; // i4
        signed int rf_input; // i4
        
    };
    const int RF_index = 22;


    struct prohibition
    {
        signed long long replID; // i8
        signed long long replRev; // i8
        signed long long replAct; // i8
        signed int prohib_id; // i4
        char client_code[8]; // c7
        signed int initiator; // i4
        char section[51]; // c50
        char code_vcb[26]; // c25
        signed int isin_id; // i4
        signed int priority; // i4
        signed long long group_mask; // i8
        signed int type; // i4
        signed int is_legacy; // i4
        
    };
    const int prohibition_index = 23;


    struct rates
    {
        signed long long replID; // i8
        signed long long replRev; // i8
        signed long long replAct; // i8
        signed int rate_id; // i4
        char curr_base[16]; // c15
        char curr_coupled[16]; // c15
        char radius[11]; // d16.5
        
    };
    const int rates_index = 24;


    struct sys_events
    {
        signed long long replID; // i8
        signed long long replRev; // i8
        signed long long replAct; // i8
        signed long long event_id; // i8
        signed int sess_id; // i4
        signed int event_type; // i4
        char message[65]; // c64
        
    };
    const int sys_events_index = 25;



#pragma pack(pop)
