#pragma pack(push, 4)

// Scheme "scheme" description
namespace FullOrderLog
{

    struct orders_log
    {
        signed long long replID; // i8
        signed long long replRev; // i8
        signed long long replAct; // i8
        signed long long id_ord; // i8
        signed int sess_id; // i4
        struct cg_time_t moment; // t
        signed int status; // i4
        signed char action; // i1
        signed int isin_id; // i4
        signed char dir; // i1
        char price[11]; // d16.5
        signed int amount; // i4
        signed int amount_rest; // i4
        signed long long id_deal; // i8
        char deal_price[11]; // d16.5
        
    };
    const int orders_log_index = 0;


    struct multileg_orders_log
    {
        signed long long replID; // i8
        signed long long replRev; // i8
        signed long long replAct; // i8
        signed long long id_ord; // i8
        signed int sess_id; // i4
        struct cg_time_t moment; // t
        signed int status; // i4
        signed char action; // i1
        signed int isin_id; // i4
        signed char dir; // i1
        char price[11]; // d16.5
        signed int amount; // i4
        signed int amount_rest; // i4
        char rate_price[11]; // d16.5
        char swap_price[11]; // d16.5
        signed long long id_deal; // i8
        char deal_price[11]; // d16.5
        
    };
    const int multileg_orders_log_index = 1;


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
    const int sys_events_index = 2;


}

#pragma pack(pop)
