import UIKit

public class CustomSegmentedControl: UIView {
    
    // Array of segment titles
    public var segments: [String]
    
    // Currently selected segment index
    public var selectedIndex: Int = 0 {
        didSet {
            // Update UI when selected index changes
            updateSegmentedControl()
            // Trigger callback when the segment changes
            segmentChanged?(selectedIndex)
        }
    }
    
    // Callback for segment change
    public var segmentChanged: ((Int) -> Void)?

    // Array to hold segment buttons
    private var buttons: [UIButton] = []
    
    // Selector view to highlight the selected segment
    private var selectorView: UIView!

    // Initializer to create the control with given segments
    public init(segments: [String] = ["Segment 1", "Segment 2"]) {
        self.segments = segments
        super.init(frame: .zero)
        setupView()
    }

    // Required initializer (not used here)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Sets up the view's UI elements and layout
    private func setupView() {
        // Set background color and corner radius
        backgroundColor = .customBlue50
        layer.cornerRadius = 8

        // Create buttons for segments
        buttons = segments.map { createButton(withTitle: $0) }

        // Initialize the selector view
        selectorView = UIView()
        selectorView.backgroundColor = .customBlue900
        selectorView.layer.cornerRadius = 8
        addSubview(selectorView)

        // Create a stack view to arrange buttons horizontally
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.axis = .horizontal // Arrange buttons horizontally
        stackView.alignment = .fill // Fill alignment
        stackView.distribution = .fillEqually // Equal button distribution
        addSubview(stackView)
        
        // Enable Auto Layout for stack view
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }

    // Creates a button for a given segment title
    private func createButton(withTitle title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal) // Set button title
        button.setTitleColor(.customBlue900, for: .normal) // Set default text color
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside) // Add tap action
        return button
    }

    // Updates the segmented control's UI based on the selected index
    private func updateSegmentedControl() {
        let buttonWidth = frame.width / CGFloat(buttons.count) // Calculate button width
        let selectorWidth = buttonWidth - 16 // Calculate selector width with padding
        let selectorHeight: CGFloat = 30 // Selector height
        let selectorX = buttonWidth * CGFloat(selectedIndex) + 8 // Calculate selector X position
        let selectorY = (frame.height - selectorHeight) / 2 // Center selector vertically

        // Animate the selector's movement
        UIView.animate(withDuration: 0.3) {
            self.selectorView.frame = CGRect(x: selectorX, y: selectorY, width: selectorWidth, height: selectorHeight)
        }

        // Update button text colors based on selection
        for (buttonIndex, button) in buttons.enumerated() {
            button.setTitleColor(buttonIndex == selectedIndex ? .customGray50 : .customBlue900, for: .normal)
        }
    }

    // Handles button tap and updates the selected index
    @objc private func buttonTapped(_ sender: UIButton) {
        guard let index = buttons.firstIndex(of: sender) else { return }
        selectedIndex = index
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        updateSegmentedControl()
    }
}

// Extension to define custom colors
extension UIColor {
    static let customBlue50 = UIColor(red: 204/255, green: 229/255, blue: 255/255, alpha: 1.0) // Light blue
    static let customBlue900 = UIColor(red: 0/255, green: 51/255, blue: 102/255, alpha: 1.0) // Dark blue
    static let customGray50 = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1.0) // Light gray
}
