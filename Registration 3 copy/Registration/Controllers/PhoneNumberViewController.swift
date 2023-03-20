import UIKit

class PhoneNumberViewController: UIViewController {
    
	// MARK: - Outlets
    @IBOutlet var phoneNumberTextField: UITextField!
    @IBOutlet var nextButton: UIButton!
    
	// MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateButtonState()
    }
	
	override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
		
		if let navigationBar = navigationController?.navigationBar as? CustomNavigationBar {
			navigationBar.setup()
		}
		
		phoneNumberTextField.text = ""
		phoneNumberTextField.becomeFirstResponder()
	}
    
	// MARK: - Update Methods
    private func updateButtonState() {
		guard let text = phoneNumberTextField.text else { return }
		
       
		let isEnabled = text.count == 18
		
		nextButton.isEnabled = isEnabled
		nextButton.backgroundColor = nextButton.isEnabled ? .blackButton : .grayButton
		
		if isEnabled {
			phoneNumberTextField.resignFirstResponder()
		}
    }
	
    // MARK: - Helpers
    private func formate(phoneNumber: String) -> String {
            
        let numbers = phoneNumber.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        let mask = "+X (XXX) XXX-XX-XX"
        var result = ""
        var index = numbers.startIndex
        
        for character in mask where index < numbers.endIndex {
            if character == "X" {
                result.append(numbers[index])
                index = numbers.index(after: index)
            } else {
                result.append(character)
            }
        }
        return result
    }
	
	// MARK: – Navigation
	@IBSegueAction func showOneTimePasscodeViewController(_ coder: NSCoder) -> OneTimePasswordViewController? {
		guard let phoneNumber = phoneNumberTextField.text else {
			fatalError("Phone number wasn't received")
		}
		
		return OneTimePasswordViewController(coder: coder, phoneNumber: phoneNumber)
	}
	
    @IBAction func unwindToPhoneNumberViewController(unwindSegue: UIStoryboardSegue) {
		
    }
}

// MARK: - UITextFieldDelegate
extension PhoneNumberViewController: UITextFieldDelegate {
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		guard let text = textField.text else { return false }
		
		let newText = (text as NSString).replacingCharacters(in: range, with: string)
		textField.text = formate(phoneNumber: newText)
		updateButtonState()
		
		return false
	}
}
