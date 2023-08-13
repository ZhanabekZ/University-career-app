//
//  NewsDetailViewController.swift
//  AITUcareer
//
//  Created by ZhZinekenov on 11.05.2023.
//
import UIKit
import WebKit

class NewsDetailViewController: UIViewController, UITextViewDelegate {
    let newsItem: NewsItem
    
    init(newsItem: NewsItem) {
        self.newsItem = newsItem
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(actionTapped))
        
        let imageView = UIImageView(image: newsItem.NewsImage)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        titleLabel.textColor = .black
        titleLabel.text = newsItem.NewsTitle
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.layer.cornerRadius = 10
        scrollView.layer.masksToBounds = true
        scrollView.isScrollEnabled = true
        scrollView.layer.shadowColor = CGColor(red: 0.086, green: 0.196, blue: 0.4118, alpha: 1)
        scrollView.layer.shadowRadius = 10
        scrollView.backgroundColor = .white
        view.addSubview(scrollView)
        
        let descriptionText = UITextView()
        descriptionText.text = newsItem.NewsDescription
        descriptionText.textColor = .black
        descriptionText.isEditable = false
        descriptionText.isScrollEnabled = false
        descriptionText.font = .systemFont(ofSize: 16, weight: .regular)
        descriptionText.dataDetectorTypes = .link
        descriptionText.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(descriptionText)
                
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalToConstant: 250),
            titleLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: -60),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            descriptionText.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 5),
            descriptionText.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            descriptionText.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            descriptionText.bottomAnchor.constraint(lessThanOrEqualTo: scrollView.bottomAnchor, constant: 5),
            descriptionText.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        // Update the content size of the text view to fit its content
            let textViewSize = descriptionText.sizeThatFits(CGSize(width: descriptionText.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
            descriptionText.contentSize = CGSize(width: textViewSize.width, height: textViewSize.height + 10) // Add some extra space to avoid clipping
    }
    @objc func actionTapped() {
        guard let image = newsItem.NewsImage.jpegData(compressionQuality: 0.9)
        else {
            print("No image found")
            return
        }
        let textToShare = newsItem.NewsTitle + "\n\n" + newsItem.NewsDescription
        let vc = UIActivityViewController(activityItems: [textToShare, image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }

    // Handle link tap events
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction:UITextItemInteraction) -> Bool {
        if interaction == .invokeDefaultAction {
            // Create and present a WKWebView to open the link
            let webView = WKWebView(frame: view.bounds)
            let webViewController = UIViewController()
            webViewController.view = webView
            webView.load(URLRequest(url: URL))
            present(webViewController, animated: true, completion: nil)
            return false
        }
        return true
    }
}


