// assets/crypto-donations/crypto-donations.ts
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
function fetchCryptoData(url) {
    return __awaiter(this, void 0, void 0, function* () {
        const response = yield fetch(url);
        return response.json();
    });
}
export function getDonations(currency, address) {
    return __awaiter(this, void 0, void 0, function* () {
        try {
            let response;
            switch (currency) {
                case 'btc':
                    const btcApiUrl = `https://api.blockcypher.com/v1/btc/main/addrs/${address}/balance`;
                    response = yield fetch(btcApiUrl);
                    if (!response.ok)
                        throw new Error('blockcypher api response was not ok');
                    const btcData = yield response.json();
                    return (btcData.total_received / 100000000).toFixed(8);
                case 'eth':
                    const etcApiUrl = `https://api.ethplorer.io/getAddressInfo/${address}?apiKey=freekey`;
                    response = yield fetch(etcApiUrl);
                    if (!response.ok)
                        throw new Error('etherscan api response was not ok');
                    const ethData = yield response.json();
                    return (ethData.ETH.balance).toFixed(18);
                case 'usdt':
                    response = yield fetch(`https://apilist.tronscan.org/api/account?address=${address}`);
                    if (!response.ok)
                        throw new Error('tronscan.org API response was not ok');
                    const usdtData = yield response.json();
                    const usdtToken = usdtData.trc20token_balances.find((token) => token.tokenAbbr === 'USDT');
                    return (usdtToken.balance / 1000000).toFixed(2); // Balance USDT
                default:
                    throw new Error('Unsupported currency');
            }
        }
        catch (error) {
            console.error('Error fetching donation data:', error);
            return '0.0';
        }
    });
}
