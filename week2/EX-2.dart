class BankAccount {
    final int _accountId;
    final String _accountName;
    double _balance = 0;
    BankAccount(this._accountId, this._accountName);

    double get balance => _balance;

    void withdraw (double amount){
      if(amount> _balance){
        throw Exception('Insufficient balance!');
      }
      _balance -=amount;
    }

    void credit(double amount) {
    if (amount <= 0) {
      throw Exception('Amount must be positive!');
    }
    _balance += amount;
    }
}

class Bank {
  final String name;
  final List<BankAccount> accounts = []; 

  Bank(this.name);

  BankAccount createAccount(int accountId, String accountOwner) {

    if (accounts.any((account) => account._accountId == accountId)) {
      throw Exception('Account ID already exists!');
    }
    var newAccount = BankAccount(accountId, accountOwner);
    accounts.add(newAccount);
    return newAccount;
  }
}
 
void main() {

  Bank myBank = Bank("CADT Bank");
  BankAccount ronanAccount = myBank.createAccount(100, 'Ronan');

  print(ronanAccount.balance); // Balance: $0
  ronanAccount.credit(100);
  print(ronanAccount.balance); // Balance: $100
  ronanAccount.withdraw(50);
  print(ronanAccount.balance); // Balance: $50

  try {
    ronanAccount.withdraw(75); // This will throw an exception
  } catch (e) {
    print(e); // Output: Insufficient balance for withdrawal!
  }

  try {
    myBank.createAccount(100, 'Honlgy'); // This will throw an exception
  } catch (e) {
    print(e); // Output: Account with ID 100 already exists!
  }
}
