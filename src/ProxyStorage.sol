// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

struct ProxyStore {
    /// @notice Admin of the proxy.
    address admin;
    /// @notice The address of the current implementation.
    address implementation;
    /// @notice The version string associated with the implemetnation.
    uint48 version;
}

/// @dev This store is consumed by both the proxy and by implementations.
struct ImplStore {
    /// @notice An address provider which the implementation uses to resolve dependencies.
    address addressProvider;
    
    /// @notice The proxy for this implementation.
    address proxy;
    
    /// @notice The address cache for the implementation's dependencies.
    mapping(bytes32 => address) addressCache;
    
    /// @notice The Unix timestamp at which the implementation was initialized.
    /// @dev The initialize() function is essentially a reimplementation of the constructor() mechanism,
    /// for delegatecall proxies.
    uint256 initializedAt;
}

contract ProxyStorage {
    bytes32 constant private STORE_SLOT = bytes32(uint(keccak256("eth.nakamofo.niacin.v1.proxy")) - 1);

    function _proxyStore() internal pure returns (ProxyStore storage store) {
        bytes32 s = STORE_SLOT;
        assembly {
            store.slot := s
        }
    }
}

contract ImplStorage {
    bytes32 constant private STORE_SLOT = bytes32(uint(keccak256("eth.nakamofo.niacin.v1.impl")) - 1);

    function _implStore() internal pure returns (ImplStore storage store) {
        bytes32 s = STORE_SLOT;
        assembly {
            store.slot := s
        }
    }
}