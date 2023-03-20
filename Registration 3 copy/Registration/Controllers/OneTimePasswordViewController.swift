import UIKit

class OneTimePasswordViewController: UIViewController {
    
	// MARK: - Outlets
	@IBOutlet var textFields: [OneTimeCodeTextField]!
    
    @IBOutlet var phoneNumberLabel: UILabel!
    @IBOutlet var nextButton: UIButton!
    
	// MARK: - Properties
	var phoneNumber: String
	
	var code: String {
		return textFields
			.compactMap { $0.text }
			.reduce("", +)
	}
	
	// MARK: - Initialization
	init?(coder: NSCoder, phoneNumber: String) {
		self.phoneNumber = phoneNumber
		
		super.init(coder: coder)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Life Cycle
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		textFields[0].becomeFirstResponder()
		phoneNumberLabel.text = "На номер \(phoneNumber) отправлен код подтверждения."
	}
    
	// MARK: - Update Methods
    private func updateButtonState() {
		if code.count == 4 {
			nextButton.setTitle("Продолжить", for: .normal)
			// присвоить действие по продолжению
		} else {
			nextButton.setTitle("Отправить код повторно", for: .normal)
			// присвоить действие по повторной отправке
		}
    }
}

extension OneTimePasswordViewController: UITextFieldDelegate {
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		if !string.isEmpty {
			if textField.text == "" {
				textField.text = string
				
				if let nextResponder = view.viewWithTag(textField.tag + 1) {
					nextResponder.becomeFirstResponder()
				} else {
					textField.resignFirstResponder()
				}
			}
		} else if textField.text == "" {
			if let nextResponder = view.viewWithTag(textField.tag - 1) as? UITextField {
				nextResponder.text = ""
				nextResponder.becomeFirstResponder()
			}
		} else {
			textField.text = ""
		}
		
		updateButtonState()
		
		return false
	}
}
