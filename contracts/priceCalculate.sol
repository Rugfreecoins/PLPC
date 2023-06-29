//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.7;

import "@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract PriceCalculator {
    using SafeMath for uint256;

    IUniswapV2Router02 public router;

    address bnb;
    address usdt;

    // address usdt;

    constructor() {
        router = IUniswapV2Router02(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);
        bnb = 0xB4FBF271143F4FBf7B91A5ded31805e42b2208d6;
        usdt = 0xa2B7Fcd5dB4db5dF736DC04Dc2c1A242B914661d;
    }

    function getLatestPrice(
        address _tokenAddress,
        uint256 _tokenAmount
    ) public view returns (uint256) {
        address[] memory path = new address[](3);
        path[0] = usdt;
        path[1] = bnb;
        path[2] = _tokenAddress;

        // get token price in bnb
        uint256[] memory amounts = router.getAmountsOut(_tokenAmount, path);

        return amounts[2];
    }
}
