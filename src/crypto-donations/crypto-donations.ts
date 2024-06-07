// assets/crypto-donations/crypto-donations.ts

async function fetchCryptoData(url: string): Promise<any> {
  const response = await fetch(url);
  return response.json();
}

export async function getDonations(currency: string, address: string): Promise<string> {
  try {
    let response;
    switch (currency) {
      case 'btc':
        const btcApiUrl = `https://api.blockcypher.com/v1/btc/main/addrs/${address}/balance`
        response = await fetch(btcApiUrl);
        if (!response.ok) throw new Error('blockcypher api response was not ok');
        const btcData = await response.json();
        return (btcData.total_received / 100000000).toFixed(8);

      case 'eth':
        const etcApiUrl = `https://api.ethplorer.io/getAddressInfo/${address}?apiKey=freekey`
        response = await fetch(etcApiUrl);
        if (!response.ok) throw new Error('etherscan api response was not ok');
        const ethData = await response.json();
        return (ethData.ETH.balance).toFixed(18);

      case 'usdt':
        response = await fetch(`https://apilist.tronscan.org/api/account?address=${address}`);
        if (!response.ok) throw new Error('tronscan.org API response was not ok');
        const usdtData = await response.json();
        const usdtToken = usdtData.trc20token_balances.find((token: any) => token.tokenAbbr === 'USDT');
        return (usdtToken.balance / 1000000).toFixed(2); // Balance USDT

      default:
        throw new Error('Unsupported currency');
    }
  } catch (error) {
    console.error('Error fetching donation data:', error);
    return '0.0';
  }
}

