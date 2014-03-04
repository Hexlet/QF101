#pragma pack(push, 4)

// Scheme "message" description
namespace message
{

    struct FutAddOrder
    {
        char broker_code[5]; // c4
        char isin[26]; // c25
        char client_code[4]; // c3
        signed int type; // i4
        signed int dir; // i4
        signed int amount; // i4
        char price[18]; // c17
        char comment[21]; // c20
        char broker_to[21]; // c20
        signed int ext_id; // i4
        signed int du; // i4
        char date_exp[9]; // c8
        signed int hedge; // i4
        signed int dont_check_money; // i4
        struct cg_time_t local_stamp; // t
        
    };
    const int FutAddOrder_index = 0;
    const int FutAddOrder_msgid = 36;


    struct FORTS_MSG101
    {
        signed int code; // i4
        char message[256]; // c255
        signed long long order_id; // i8
        
    };
    const int FORTS_MSG101_index = 1;
    const int FORTS_MSG101_msgid = 101;


    struct FutAddMultiLegOrder
    {
        char broker_code[5]; // c4
        signed int sess_id; // i4
        signed int isin_id; // i4
        char client_code[4]; // c3
        signed int type; // i4
        signed int dir; // i4
        signed int amount; // i4
        char price[18]; // c17
        char rate_price[18]; // c17
        char comment[21]; // c20
        signed int hedge; // i4
        char broker_to[21]; // c20
        signed int ext_id; // i4
        signed int trust; // i4
        char date_exp[9]; // c8
        signed int trade_mode; // i4
        signed int dont_check_money; // i4
        struct cg_time_t local_stamp; // t
        
    };
    const int FutAddMultiLegOrder_index = 2;
    const int FutAddMultiLegOrder_msgid = 40;


    struct FORTS_MSG129
    {
        signed int code; // i4
        char message[256]; // c255
        signed long long order_id; // i8
        
    };
    const int FORTS_MSG129_index = 3;
    const int FORTS_MSG129_msgid = 129;


    struct FutDelOrder
    {
        char broker_code[5]; // c4
        signed long long order_id; // i8
        struct cg_time_t local_stamp; // t
        
    };
    const int FutDelOrder_index = 4;
    const int FutDelOrder_msgid = 37;


    struct FORTS_MSG102
    {
        signed int code; // i4
        char message[256]; // c255
        signed int amount; // i4
        
    };
    const int FORTS_MSG102_index = 5;
    const int FORTS_MSG102_msgid = 102;


    struct FutDelUserOrders
    {
        char broker_code[5]; // c4
        signed int buy_sell; // i4
        signed int non_system; // i4
        char code[4]; // c3
        char code_vcb[26]; // c25
        signed int ext_id; // i4
        signed int work_mode; // i4
        char isin[26]; // c25
        struct cg_time_t local_stamp; // t
        
    };
    const int FutDelUserOrders_index = 6;
    const int FutDelUserOrders_msgid = 38;


    struct FORTS_MSG103
    {
        signed int code; // i4
        char message[256]; // c255
        signed int num_orders; // i4
        
    };
    const int FORTS_MSG103_index = 7;
    const int FORTS_MSG103_msgid = 103;


    struct FutMoveOrder
    {
        char broker_code[5]; // c4
        signed int regime; // i4
        signed long long order_id1; // i8
        signed int amount1; // i4
        char price1[18]; // c17
        signed int ext_id1; // i4
        signed long long order_id2; // i8
        signed int amount2; // i4
        char price2[18]; // c17
        signed int ext_id2; // i4
        struct cg_time_t local_stamp; // t
        
    };
    const int FutMoveOrder_index = 8;
    const int FutMoveOrder_msgid = 39;


    struct FORTS_MSG105
    {
        signed int code; // i4
        char message[256]; // c255
        signed long long order_id1; // i8
        signed long long order_id2; // i8
        
    };
    const int FORTS_MSG105_index = 9;
    const int FORTS_MSG105_msgid = 105;


    struct OptAddOrder
    {
        char broker_code[5]; // c4
        char isin[26]; // c25
        char client_code[4]; // c3
        signed int type; // i4
        signed int dir; // i4
        signed int amount; // i4
        char price[18]; // c17
        char comment[21]; // c20
        char broker_to[21]; // c20
        signed int ext_id; // i4
        signed int du; // i4
        signed int check_limit; // i4
        char date_exp[9]; // c8
        signed int hedge; // i4
        signed int dont_check_money; // i4
        struct cg_time_t local_stamp; // t
        
    };
    const int OptAddOrder_index = 10;
    const int OptAddOrder_msgid = 41;


    struct FORTS_MSG109
    {
        signed int code; // i4
        char message[256]; // c255
        signed long long order_id; // i8
        
    };
    const int FORTS_MSG109_index = 11;
    const int FORTS_MSG109_msgid = 109;


    struct OptDelOrder
    {
        char broker_code[5]; // c4
        signed long long order_id; // i8
        struct cg_time_t local_stamp; // t
        
    };
    const int OptDelOrder_index = 12;
    const int OptDelOrder_msgid = 42;


    struct FORTS_MSG110
    {
        signed int code; // i4
        char message[256]; // c255
        signed int amount; // i4
        
    };
    const int FORTS_MSG110_index = 13;
    const int FORTS_MSG110_msgid = 110;


    struct OptDelUserOrders
    {
        char broker_code[5]; // c4
        signed int buy_sell; // i4
        signed int non_system; // i4
        char code[4]; // c3
        char code_vcb[26]; // c25
        signed int ext_id; // i4
        signed int work_mode; // i4
        char isin[26]; // c25
        struct cg_time_t local_stamp; // t
        
    };
    const int OptDelUserOrders_index = 14;
    const int OptDelUserOrders_msgid = 43;


    struct FORTS_MSG111
    {
        signed int code; // i4
        char message[256]; // c255
        signed int num_orders; // i4
        
    };
    const int FORTS_MSG111_index = 15;
    const int FORTS_MSG111_msgid = 111;


    struct OptMoveOrder
    {
        char broker_code[5]; // c4
        signed int regime; // i4
        signed long long order_id1; // i8
        signed int amount1; // i4
        char price1[18]; // c17
        signed int ext_id1; // i4
        signed int check_limit; // i4
        signed long long order_id2; // i8
        signed int amount2; // i4
        char price2[18]; // c17
        signed int ext_id2; // i4
        struct cg_time_t local_stamp; // t
        
    };
    const int OptMoveOrder_index = 16;
    const int OptMoveOrder_msgid = 44;


    struct FORTS_MSG113
    {
        signed int code; // i4
        char message[256]; // c255
        signed long long order_id1; // i8
        signed long long order_id2; // i8
        
    };
    const int FORTS_MSG113_index = 17;
    const int FORTS_MSG113_msgid = 113;


    struct FutChangeClientMoney
    {
        char broker_code[5]; // c4
        signed int mode; // i4
        char code[4]; // c3
        char limit_money[18]; // c17
        char limit_pledge[18]; // c17
        char coeff_liquidity[18]; // c17
        char coeff_go[18]; // c17
        signed int is_auto_update_limit; // i4
        signed int is_auto_update_spot_limit; // i4
        char limit_spot_buy[18]; // c17
        signed int no_fut_discount; // i4
        signed int check_limit; // i4
        
    };
    const int FutChangeClientMoney_index = 18;
    const int FutChangeClientMoney_msgid = 60;


    struct FORTS_MSG104
    {
        signed int code; // i4
        char message[256]; // c255
        
    };
    const int FORTS_MSG104_index = 19;
    const int FORTS_MSG104_msgid = 104;


    struct FutChangeClientVcb
    {
        char broker_code[5]; // c4
        signed int mode; // i4
        char code[4]; // c3
        char code_vcb[26]; // c25
        char coeff_go[18]; // c17
        char limit_spot[11]; // c10
        
    };
    const int FutChangeClientVcb_index = 20;
    const int FutChangeClientVcb_msgid = 33;


    struct FORTS_MSG106
    {
        signed int code; // i4
        char message[256]; // c255
        
    };
    const int FORTS_MSG106_index = 21;
    const int FORTS_MSG106_msgid = 106;


    struct FutChangeBrokerVcb
    {
        char broker_code[5]; // c4
        signed int mode; // i4
        char code_vcb[26]; // c25
        char limit_spot[11]; // c10
        
    };
    const int FutChangeBrokerVcb_index = 22;
    const int FutChangeBrokerVcb_msgid = 14;


    struct FORTS_MSG114
    {
        signed int code; // i4
        char message[256]; // c255
        
    };
    const int FORTS_MSG114_index = 23;
    const int FORTS_MSG114_msgid = 114;


    struct FutChangeBFMoney
    {
        char broker_code[5]; // c4
        signed int mode; // i4
        char code[3]; // c2
        char limit_money[18]; // c17
        char limit_pledge[18]; // c17
        
    };
    const int FutChangeBFMoney_index = 24;
    const int FutChangeBFMoney_msgid = 7;


    struct FORTS_MSG107
    {
        signed int code; // i4
        char message[256]; // c255
        
    };
    const int FORTS_MSG107_index = 25;
    const int FORTS_MSG107_msgid = 107;


    struct FutChangeMoney
    {
        char broker_code[5]; // c4
        signed int mode; // i4
        char limit_spot_buy[18]; // c17
        signed int is_auto_update_spot_limit; // i4
        signed int state; // i4
        
    };
    const int FutChangeMoney_index = 26;
    const int FutChangeMoney_msgid = 16;


    struct FORTS_MSG116
    {
        signed int code; // i4
        char message[256]; // c255
        
    };
    const int FORTS_MSG116_index = 27;
    const int FORTS_MSG116_msgid = 116;


    struct OptChangeExpiration
    {
        char broker_code[5]; // c4
        signed int mode; // i4
        signed int order_id; // i4
        char code[4]; // c3
        char isin[26]; // c25
        signed int amount; // i4
        
    };
    const int OptChangeExpiration_index = 28;
    const int OptChangeExpiration_msgid = 12;


    struct FORTS_MSG112
    {
        signed int code; // i4
        char message[256]; // c255
        signed int order_id; // i4
        
    };
    const int FORTS_MSG112_index = 29;
    const int FORTS_MSG112_msgid = 112;


    struct FutChangeClientProhibit
    {
        char broker_code[5]; // c4
        signed int mode; // i4
        char code[4]; // c3
        char code_vcb[26]; // c25
        char isin[26]; // c25
        signed int state; // i4
        signed int state_mask; // i4
        
    };
    const int FutChangeClientProhibit_index = 30;
    const int FutChangeClientProhibit_msgid = 15;


    struct FORTS_MSG115
    {
        signed int code; // i4
        char message[256]; // c255
        
    };
    const int FORTS_MSG115_index = 31;
    const int FORTS_MSG115_msgid = 115;


    struct OptChangeClientProhibit
    {
        char broker_code[5]; // c4
        signed int mode; // i4
        char code[4]; // c3
        char code_vcb[26]; // c25
        char isin[26]; // c25
        signed int state; // i4
        signed int state_mask; // i4
        
    };
    const int OptChangeClientProhibit_index = 32;
    const int OptChangeClientProhibit_msgid = 17;


    struct FORTS_MSG117
    {
        signed int code; // i4
        char message[256]; // c255
        
    };
    const int FORTS_MSG117_index = 33;
    const int FORTS_MSG117_msgid = 117;


    struct FutExchangeBFMoney
    {
        char broker_code[5]; // c4
        signed int mode; // i4
        char code_from[3]; // c2
        char code_to[3]; // c2
        char amount_money[18]; // c17
        char amount_pledge[18]; // c17
        
    };
    const int FutExchangeBFMoney_index = 34;
    const int FutExchangeBFMoney_msgid = 33;


    struct FORTS_MSG130
    {
        signed int code; // i4
        char message[256]; // c255
        
    };
    const int FORTS_MSG130_index = 35;
    const int FORTS_MSG130_msgid = 130;


    struct OptRecalcCS
    {
        char broker_code[5]; // c4
        signed int isin_id; // i4
        
    };
    const int OptRecalcCS_index = 36;
    const int OptRecalcCS_msgid = 45;


    struct FORTS_MSG132
    {
        signed int code; // i4
        char message[256]; // c255
        
    };
    const int FORTS_MSG132_index = 37;
    const int FORTS_MSG132_msgid = 132;


    struct FORTS_MSG99
    {
        signed int queue_size; // i4
        signed int penalty_remain; // i4
        char message[129]; // c128
        signed int code; // i4
        
    };
    const int FORTS_MSG99_index = 38;
    const int FORTS_MSG99_msgid = 99;


    struct FORTS_MSG100
    {
        signed int code; // i4
        char message[256]; // c255
        
    };
    const int FORTS_MSG100_index = 39;
    const int FORTS_MSG100_msgid = 100;


}

#pragma pack(pop)
