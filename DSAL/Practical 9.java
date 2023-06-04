// Author : Arshad Khan
// Instgram : khan0003.py

import java.util.*;

public class Main {
    private static int N = 20;

    public static void maxHeapify(int arr[], int n, int i) {
        int left = 2 * i;
        int right = 2 * i + 1;
        int largest = i;

        if (left <= n && arr[left] > arr[largest]) {
            largest = left;
        }

        if (right <= n && arr[right] > arr[largest]) {
            largest = right;
        }

        if (largest != i) {
            int temp = arr[i];
            arr[i] = arr[largest];
            arr[largest] = temp;
            maxHeapify(arr, n, largest);
        }
    }

    public static void heapSort(int arr[], int n) {
        for (int i = n / 2; i >= 1; i--) {
            maxHeapify(arr, n, i);
        }

        for (int i = n; i >= 1; i--) {
            int temp = arr[1];
            arr[1] = arr[i];
            arr[i] = temp;
            maxHeapify(arr, i - 1, 1);
        }
    }

    public static void main(String[] args) {
        int[] heap = new int[N];

        Scanner sc = new Scanner(System.in);
        System.out.println("Enter how many numbers you want to insert: ");
        int n = sc.nextInt();
        System.out.println("Enter numbers: ");
        for (int i = 1; i <= n; i++) {
            int val = sc.nextInt();
            heap[i] = val;
        }

        heapSort(heap, n);

        System.out.println("Sorted numbers:");
        for (int i = 1; i <= n; i++) {
            System.out.println(heap[i]);
        }
    }
}

// ©arshad_khan