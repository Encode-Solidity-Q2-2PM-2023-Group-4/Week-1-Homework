// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

/// @title A contract for testing ownership
/// @author Linus Kelsey
/// @notice A contract to test admins being added consecutively
contract HelloWorld {

    /// @dev text is the output string of the helloWorld method
    string private text;
    /// @dev owner is the original contract deployer
    address public owner;
    /// @dev owners is a list of admins
    address[] public owners;
    /// @dev ownersBool is a mapping indicating whether an address is an admin
    mapping (address => bool) public ownersBool;

    /// @notice onlOwner checks if an address is an owner
    /// @dev Uses ownersBool, which has default vals of false for non-admins
    modifier onlyOwner() {
        require(ownersBool[msg.sender] == true, "Caller is not an admin.");
        _;
    }

    /// @notice Initialising the contract
    constructor() {
        text = "Hello World";
        owner = msg.sender;
        owners = [owner];
        ownersBool[owner] = true;
    }

    /// @notice The main helloWorld function
    /// @return The text string, default of "Hello World"
    function helloWorld() public view returns (string memory) {
        return text;
    }

    /// @notice Changes text string, only possible if caller is an admin
    function setText(string calldata newText) public onlyOwner {
        text = newText;
    }

    /// @notice Add admins, only possible if caller admin
    function increaseOwnership(address newOwner) public onlyOwner {
        owners.push(newOwner);
        ownersBool[newOwner] = true;
    }

    /// @notice See all admins, possible for any caller
    function getOwners() public view returns (address[] memory) {
        return owners;
    }
}