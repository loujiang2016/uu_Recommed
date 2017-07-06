//
//  Uur_HttpRequestConstants.m
//  UU_Recommed_SDK
//
//  Created by Jiang Lou on 2017/7/6.
//  Copyright © 2017年 Jiang Lou. All rights reserved.
//

#import "Uur_HttpRequestConstants.h"

@implementation Uur_HttpRequestConstants

NSString * const uur_get_mchkcode_HttpInterface=@"/front/account/uur_get_mchkcode.json";

NSString * const uur_register_account_HttpInterface=@"/front/account/uur_register_account.json";

NSString * const uur_loing_by_account_HttpInterface=@"/front/account/uur_login_by_account.json";

NSString *const uur_logout_HttpInterface=@"/front/account/uur_logout.json";

NSString * const uur_login_by_mobile_HttpInterface=@"/front/account/uur_login_by_mobile.json";


NSString *const uur_check_mobile_name_HttpInterface=@"/front/account/uur_check_mobile_name.json";



NSString *const uur_check_token_status_HttpInterface=@"/front/account/uur_check_token_status.json";


NSString * const uur_user_info_HttpInterface=@"/register/uur_user_info.json";

NSString * const uur_get_avatars_HttpInterface=@"/register/uur_get_avatars.json";

NSString * const uur_change_default_avatar_HttpInterface=@"/register/uur_change_default_avatar.json";


NSString *const uur_upload_avatar_HttpInterface=@"/register/uur_upload_avatar.json";


NSString *const   uur_get_support_banks_HttpInterface=@"/register/uur_user_bank_cards.json";

NSString *const  uur_binding_bank_card_HttpInterface=@"/register/uur_binding_bank_card.json";

NSString *const  uur_unbound_bank_card_HttpInterface=@"/register/uur_unbound_bank_card.json";


NSString *const  uur_verify_bank_card_HttpInterface=@"/register/uur_verify_bank_card.json";

NSString * const uur_verify_real_name_HttpInterface=@"/register/uur_verify_real_name.json";


NSString *const uur_mock_app_pictures_HttpInterface=@"/sys/uur_get_app_pics.json";

@end
