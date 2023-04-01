import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';
import 'package:wemeet_dapps/constants/connection.dart';

class Reward {

  //API get total token from metamask
    Future<BigInt> getTotalToken(String studentMetamaskAddress) async {
      final client = Web3Client(Connection.INFURA_GOERLI_ENDPOINT, http.Client());
      final contract = DeployedContract(
      ContractAbi.fromJson(Connection.CONTRACT_ABI, 'UTHMToken'), EthereumAddress.fromHex(Connection.TOKEN_ADDRESS));
     
      final walletAddress = EthereumAddress.fromHex(studentMetamaskAddress); 
      final balanceFunc = contract.function('balanceOf');
      final response = await client.call(
        contract: contract,
        function: balanceFunc,
        params: [walletAddress],
      );

    final balance = response.first as BigInt;
    return balance;
    }
}