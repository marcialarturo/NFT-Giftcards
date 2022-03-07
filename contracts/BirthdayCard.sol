// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "./AggregatorV3Interface.sol";



contract BirthdayCard is ERC721 {

    AggregatorV3Interface internal priceFeed;
    uint public giftcardCount = 0;
    mapping(uint => Giftcard) public giftcard;

    constructor() ERC721("Bday", "BDAY") public  {
        priceFeed = AggregatorV3Interface(0x5498BB86BC934c8D34FDA08E81D444153d0D06aD);
    }

    struct Giftcard {
    uint id;
    string title;
    string description;
    string image;
    address payable owner;
  }

    event BirthdayCardCreated (
        uint tokenId,
        string imageURL,
        uint date,
        address payable from
    );


    /**
     * Returns the latest price
     */
    function getLatestPrice() public view returns (int) {
        (
            uint80 roundID,
            int price,
            uint startedAt,
            uint timeStamp,
            uint80 answeredInRound
        ) = priceFeed.latestRoundData();
        return price;
    }


    function mintBirthdayCard(string memory _tokenURI) external {
        uint _tokenId = totalSupply().add(1);
        _safeMint(msg.sender, _tokenId);
        _setTokenURI(_tokenId, _tokenURI);

        emit BirthdayCardCreated(_tokenId, _tokenURI, now, msg.sender);
    }

}




// pragma solidity 0.6.12;
// import "@openzeppelin/contracts/token/ERC721/ERC721.sol";


// contract Community is ERC721 {

// // To register communities
//   mapping(uint => CommunityTemplate) public communityList;
//   uint public count =0;

//   struct CommunityTemplate {
//     uint id;
//     string imageURL;
//     string communityName;
//     string description;
//     string physicalAddress;
//     address walletAddress;
//   }

//   event CommunityTemplateCreated (
//     uint id,
//     string imageURL,
//     string communityName,
//     string description,
//     string physicalAddress,
//     address walletAddress
//   );

//   constructor() ERC721("Community Contract", "CG")  public {}

// // upload img to textile n gives back a cid then save it to the contract => I have the cid img url
// // store whole data first try the image, json obj for data
//   function registerCommunity(string memory _imageURL, string memory _communityName, string memory _description, string memory _physicalAddress, address  _walletAddress) external {
//     count++;
//     communityList[count] = CommunityTemplate(count, _imageURL, _communityName, _description, _physicalAddress, _walletAddress);
//     emit CommunityTemplateCreated(count, _imageURL, _communityName, _description, _physicalAddress, _walletAddress);
//   }


  // event ComunityNFTCreated (
  //   uint id;
  //   string cid;
  //   string communityName;
  //   string description;
  //   string address;
  //   uint walletAddress;
  //   address payable from;
  // );

  // event ComunityNFTCreated (
  //   uint id;
  //   string cid;
  //   string communityName;
  //   string description;
  //   string address;
  //   uint walletAddress;
  //   address payable from;
  // );

  // function mintPetNFT(string memory _tokenURI) external {
  //   uint _tokenId = totalSupply().add(1);
  //   _safeMint(msg.sender, _tokenId);
  //   _setTokenURI(_tokenId, _tokenURI);
  //   emit PetNFTCreated(_tokenId, _tokenURI, now, msg.sender);
  // }
// }
