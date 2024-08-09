// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract MoneyContract {
    // Evento para registrar depósitos
    event Deposited(address indexed from, uint256 amount);

    // Evento para registrar retiradas
    event Withdrawn(address indexed to, uint256 amount);

    // Função para depositar Ether no contrato
    function deposit() public payable {
        // 'msg.value' é o valor em Ether enviado para o contrato
        emit Deposited(msg.sender, msg.value); // Emite um evento de depósito
    }

    // Função de visão para obter o saldo do contrato
    function getContractBalance() public view returns (uint256) {
        return address(this).balance; // Retorna o saldo do contrato
    }

    // Função para retirar todo o Ether do contrato para o remetente da mensagem
    function withdrawAll() public {
        uint256 balance = address(this).balance; // Obtém o saldo do contrato
        require(balance > 0, "No Ether to withdraw"); // Verifica se há Ether para retirar
        payable(msg.sender).transfer(balance); // Envia todo o saldo para o remetente
        emit Withdrawn(msg.sender, balance); // Emite um evento de retirada
    }

    // Função para retirar Ether para um endereço específico
    function withdrawTo(address payable _to, uint256 _amount) public {
        uint256 balance = address(this).balance; // Obtém o saldo do contrato
        require(_amount <= balance, "Insufficient funds"); // Verifica se há saldo suficiente
        _to.transfer(_amount); // Envia o valor especificado para o endereço fornecido
        emit Withdrawn(_to, _amount); // Emite um evento de retirada
    }
}
