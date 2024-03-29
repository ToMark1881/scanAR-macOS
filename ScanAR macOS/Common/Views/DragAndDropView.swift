//
//  DragAndDropView.swift
//  ScanAR macOS
//
//  Created by Vladyslav Vdovychenko on 17.01.2023.
//

import Cocoa

public final class DragAndDropView: NSView {
    
    // highlight the drop zone when mouse drag enters the drop view
    fileprivate var highlight : Bool = false
    
    // check if the dropped file type is accepted
    fileprivate var fileTypeIsOk = false
    
    /// Allowed file type extensions to drop, eg: ["png", "jpg", "jpeg"]
    public var acceptedFileExtensions : [String] = []
    
    weak var delegate: DragAndDropViewDelegate?
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        registerForDraggedTypes([NSPasteboard.PasteboardType.URL])
        addTapGesture()
    }
    
    public override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    public override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        // Drawing code here.
        NSColor.clear.set()
        
        __NSRectFillUsingOperation(dirtyRect, NSCompositingOperation.sourceOver)
        
        let grayColor = NSColor(deviceWhite: 1, alpha: highlight ? 0.75 : 0.5)
        grayColor.set()
        grayColor.setFill()
        
        let bounds = self.bounds
        let size = min(bounds.size.width - 8.0, bounds.size.height - 8.0);
        let width =  max(2.0, size / 64.0)
        let frame = NSMakeRect((bounds.size.width-size)/2.0, (bounds.size.height-size)/2.0, size, size)
        
        NSBezierPath.defaultLineWidth = width
        
        // draw rounded corner square with dotted borders
        let squarePath = NSBezierPath(roundedRect: frame, xRadius: size/14.0, yRadius: size/14.0)
        let dash : [CGFloat] = [size / 10.0, size / 16.0]
        squarePath.setLineDash(dash, count: 2, phase: 2)
        squarePath.stroke()
        
        // draw arrow
        let arrowPath = NSBezierPath()
        let baseWidth = size / 12
        let baseHeight = size / 12
        let arrowWidth = baseWidth * 2.0
        let pointHeight = baseHeight * 3.0
        let offset = -size / 12
        
        arrowPath.move(to: NSMakePoint(bounds.size.width/2.0 - baseWidth, bounds.size.height/2.0 + baseHeight - offset))
        
        arrowPath.line(to: NSMakePoint(bounds.size.width/2.0 + baseWidth, bounds.size.height/2.0 + baseHeight - offset))
        arrowPath.line(to: NSMakePoint(bounds.size.width/2.0 + baseWidth, bounds.size.height/2.0 - baseHeight - offset))
        arrowPath.line(to: NSMakePoint(bounds.size.width/2.0 + arrowWidth, bounds.size.height/2.0 - baseHeight - offset))
        arrowPath.line(to: NSMakePoint(bounds.size.width/2.0, bounds.size.height/2.0 - pointHeight - offset))
        arrowPath.line(to: NSMakePoint(bounds.size.width/2.0 - arrowWidth, bounds.size.height/2.0 - baseHeight - offset))
        arrowPath.line(to: NSMakePoint(bounds.size.width/2.0 - baseWidth, bounds.size.height/2.0 - baseHeight - offset))
        
        arrowPath.fill()
    }
    
    // MARK: - NSDraggingDestination
    public override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        highlight = true
        fileTypeIsOk = isExtensionAcceptable(draggingInfo: sender)
        
        self.setNeedsDisplay(self.bounds)
        return []
    }
    
    public override func draggingExited(_ sender: NSDraggingInfo?) {
        highlight = false
        self.setNeedsDisplay(self.bounds)
    }
    
    public override func draggingUpdated(_ sender: NSDraggingInfo) -> NSDragOperation {
        return fileTypeIsOk ? .copy : []
    }
    
    public override func prepareForDragOperation(_ sender: NSDraggingInfo) -> Bool {
        // finished with dragging so remove any highlighting
        highlight = false
        self.setNeedsDisplay(self.bounds)
        
        return true
    }
    
    public override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        if sender.filePathURLs.count == 0 {
            return false
        }
        
        if fileTypeIsOk {
            if sender.filePathURLs.count == 1 {
                delegate?.dragDropView(self, droppedFileWithURL: sender.filePathURLs.first!)
            } else {
                delegate?.dragDropView(self, droppedFilesWithURLs: sender.filePathURLs)
            }
        }
        
        return true
    }
    
    fileprivate func isExtensionAcceptable(draggingInfo: NSDraggingInfo) -> Bool {
        if draggingInfo.filePathURLs.count == 0 {
            return false
        }
        
        if acceptedFileExtensions.isEmpty { return true }
        
        for filePathURL in draggingInfo.filePathURLs {
            let fileExtension = filePathURL.pathExtension.lowercased()
            
            if !acceptedFileExtensions.contains(fileExtension) {
                return false
            }
        }
        
        return true
    }
    
    fileprivate func addTapGesture() {
        let tapGesture = NSClickGestureRecognizer(target: self, action: #selector(didTapOnDragAndDropView))
        
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc fileprivate func didTapOnDragAndDropView(_ sender: NSClickGestureRecognizer) {
        delegate?.dragDropView(didTapOnOpenDirectory: self)
    }
    
    public override func acceptsFirstMouse(for event: NSEvent?) -> Bool {
        return true
    }
    
}

protocol DragAndDropViewDelegate: AnyObject {
    func dragDropView(_ dragDropView: DragAndDropView, droppedFileWithURL URL: URL)
    func dragDropView(_ dragDropView: DragAndDropView, droppedFilesWithURLs URLs: [URL])
    
    func dragDropView(didTapOnOpenDirectory dragDropView: DragAndDropView)
}

extension DragAndDropViewDelegate {
    func dragDropView(_ dragDropView: DragAndDropView, droppedFileWithURL URL: URL) { }
    func dragDropView(_ dragDropView: DragAndDropView, droppedFilesWithURLs URLs: [URL]) { }
}
