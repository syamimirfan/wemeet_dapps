import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';
import 'package:wemeet_dapps/constants/connection.dart';
import 'package:wemeet_dapps/constants/utils.dart';

class Reward {

    //API to get attendance in student
  Future getReward() async {
     EasyLoading.show(
        status: "Loading...",
        maskType: EasyLoadingMaskType.black,
      );
    final response = await http.get(Uri.parse('${Utils.baseURL}/admin/getAPI'),
      headers: {
        "Accept": "Application/json",
      }
    );
     if(response.statusCode ==  200) {
       EasyLoading.dismiss();
       return jsonDecode(response.body);
     }else{ 
       EasyLoading.showError("ERROR!");
       throw Exception(response.statusCode);
     }
  }

  //API get total token from metamask
Future<BigInt> getTotalToken(String studentMetamaskAddress, String INFURA_SEPOLIA_ENDPOINT, String TOKEN_ADDRESS, String CONTRACT_ABI) async {
  final client = Web3Client(INFURA_SEPOLIA_ENDPOINT, http.Client());
  final contract = DeployedContract(
    ContractAbi.fromJson(CONTRACT_ABI, 'UTHMToken'),
    EthereumAddress.fromHex(TOKEN_ADDRESS),
  );

  final walletAddress = EthereumAddress.fromHex(studentMetamaskAddress);
  final balanceFunc = contract.function('balanceOf');
  final response = await client.call(
    contract: contract,
    function: balanceFunc,
    params: [walletAddress],
  );

  final balanceWei = response[0] as BigInt;
  final balance = EtherAmount.fromBigInt(EtherUnit.wei, balanceWei);
  final formattedBalance = balance.getValueInUnit(EtherUnit.ether).toString();

  return BigInt.parse(formattedBalance.split('.')[0]);
 }  

}