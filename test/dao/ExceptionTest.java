/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import org.junit.Test;

public class ExceptionTest {

    // Test case 1: Chia cho 0 -> ArithmeticException
    @Test(expected = ArithmeticException.class)
    public void testDivideByZero() {
        int number = 10 / 0; // sẽ ném ArithmeticException
    }

    // Test case 2: Gọi phương thức trên biến null -> NullPointerException
    @Test(expected = NullPointerException.class)
    public void testNullPointer() {
        String str = null;
        str.length(); // sẽ ném NullPointerException
    }

    public void checkAge(int age) {
        if (age < 0) {
            throw new IllegalArgumentException("Age cannot be negative!");
        }
    }

    // Test case 3: Truyền age < 0 -> IllegalArgumentException
    @Test(expected = IllegalArgumentException.class)
    public void testCheckAgeThrowsException() {
        checkAge(-5); // sẽ ném IllegalArgumentException
    }
}
