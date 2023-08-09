// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Internal references
import {AddressProvider} from "../AddressProvider.sol";
import {ImplStorage} from "../ProxyStorage.sol";

/// @notice A mixin which allows a contract to have one-off logic run on deployment, inside the initialize() function.
abstract contract MixinInitializable is 
    ImplStorage
{
    /* ========== MODIFIERS ========== */

    modifier initializer() {
        // Return if contract has already been initialized.
        if(0 < _implStore().initializedAt) return;

        // Check only the proxy is calling this function.
        require(
            msg.sender == _implStore().proxy, 
            "niacin: only proxy can initialize"
        );

        _implStore().initializedAt = block.timestamp;
        _;
    }

    /// @notice An abstract "constructor" function to be implemented by the contract.
    /// @dev This function is called by the proxy.
    function initialize() 
        external 
        virtual 
        initializer
    {}
}
