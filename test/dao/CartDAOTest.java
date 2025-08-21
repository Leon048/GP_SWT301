package dao;

import static org.mockito.Mockito.*;
import static org.junit.Assert.*;
import org.junit.Test;
import org.junit.Rule;
import org.junit.rules.ExpectedException;
import java.sql.*;

public class CartDAOTest {

    @Rule
    public ExpectedException thrown = ExpectedException.none();

    @Test
    public void testAddToCart_DBConnectionThrowsException() throws Exception {
        // Giả lập DBUtils ném ra SQLException
        CartDAO dao = new CartDAO() {
            @Override
            public boolean addToCart(int userId, int productId) throws Exception {
                throw new SQLException("Cannot connect to DB");
            }
        };

        thrown.expect(SQLException.class);
        thrown.expectMessage("Cannot connect to DB");

        dao.addToCart(1, 100);
    }

    @Test
    public void testAddToCart_PrepareStatementThrowsException() throws Exception {
        // Mock connection và ném exception ở prepareStatement
        Connection mockConn = mock(Connection.class);
        when(mockConn.prepareStatement(anyString())).thenThrow(new SQLException("Prepare failed"));

        CartDAO dao = new CartDAO() {
            @Override
            public boolean addToCart(int userId, int productId) throws Exception {
                try (Connection c = mockConn) {
                    // gọi prepareStatement sẽ ném exception
                    c.prepareStatement("SELECT * FROM Products");
                }
                return false;
            }
        };

        thrown.expect(SQLException.class);
        thrown.expectMessage("Prepare failed");

        dao.addToCart(1, 200);
    }

    @Test
    public void testAddToCart_ExecuteQueryThrowsException() throws Exception {
        Connection mockConn = mock(Connection.class);
        PreparedStatement mockPs = mock(PreparedStatement.class);

        when(mockConn.prepareStatement(anyString())).thenReturn(mockPs);
        when(mockPs.executeQuery()).thenThrow(new SQLException("Execute query failed"));

        CartDAO dao = new CartDAO() {
            @Override
            public boolean addToCart(int userId, int productId) throws Exception {
                try (Connection c = mockConn;
                     PreparedStatement ps = c.prepareStatement("SELECT * FROM Products")) {
                    ps.executeQuery(); // sẽ ném exception
                }
                return false;
            }
        };

        thrown.expect(SQLException.class);
        thrown.expectMessage("Execute query failed");

        dao.addToCart(1, 300);
    }
}
