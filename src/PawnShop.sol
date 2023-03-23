// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "lib/openzeppelin-contracts/contracts/utils/Counters.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import "lib/foundry-starter-kit/lib/chainlink-brownie-contracts/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract Aitch5Store is ERC721Enumerable, ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;
    address owner;
    AggregatorV3Interface internal priceFeed;

    // NETWORK: MAINNET
    //AGGREGATOR: USDT/ETH
    //ADDRESS: 0xEe9F2375b4bdF6387aa8265dD4FB8F16512A1d46

    constructor() ERC721("Aitch5Store", "A5S") {
        owner = msg.sender;
        priceFeed = AggregatorV3Interface(
            0xEe9F2375b4bdF6387aa8265dD4FB8F16512A1d46
        );
    }

    function getUsdtEth() public view returns (int) {
        //pretier-ignore
        (, int price, , , ) = priceFeed.latestRoundData();
        return price;
    }

    function purchaseItem(address _contractAddr, string memory _uri) public {
        uint usdtEthRate = (1 * 1e18) / uint(getUsdtEth());
        uint itemPrice = usdtEthRate * (3.5 * 1e18);
        require(msg.sender != address(0), "Address zero prohibitted");
        require(
            IERC20(_contractAddr).balanceOf(msg.sender) >= itemPrice,
            "Insufficient Fund"
        );
        IERC20(_contractAddr).transferFrom(
            msg.sender,
            address(this),
            itemPrice
        );

        safeMint(msg.sender, _uri);
    }

    function safeMint(address to, string memory uri) internal {
        // require(
        //     // _tokenIdCounter.current() <= maxSupply,
        //     "Sorry, max allowable mint reached"
        // );
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId,
        uint256 batchSize
    ) internal override(ERC721, ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }

    function _burn(
        uint256 tokenId
    ) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(
        uint256 tokenId
    ) public view override(ERC721, ERC721URIStorage) returns (string memory) {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(
        bytes4 interfaceId
    ) public view override(ERC721, ERC721Enumerable) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}
