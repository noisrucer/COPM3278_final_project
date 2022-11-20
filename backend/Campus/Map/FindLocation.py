import cv2

# read image
image = cv2.imread('CampusMap.png')
# show the image, provide window name first
# add wait key. window waits until user presses a key


def draw_circle(event, x, y, flags, param):
    global mouseX, mouseY
    if event == cv2.EVENT_LBUTTONDBLCLK:
        cv2.circle(image, (x, y), 5, (255, 0, 0), -1)
        mouseX, mouseY = x, y


cv2.namedWindow('image')
cv2.setMouseCallback('image', draw_circle)

# cv2.arrowedLine(image, (233, 572), (181, 673), (255, 0, 0), 2)

while(1):
    cv2.imshow('image', image)
    k = cv2.waitKey(20) & 0xFF
    if k == 27:
        break
    elif k == ord('a'):
        print(mouseX, mouseY)  # and finally destroy/close all open windows

cv2.destroyAllWindows()
