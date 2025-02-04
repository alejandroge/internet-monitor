package main

import (
    "fmt"
    "net/http"
    "log"
    "database/sql"
    "encoding/json"

    _ "modernc.org/sqlite"
)

// NetworkDisconnection type
type NetworkDisconnection struct {
    ID              int `json:"id"`
    CreatedAt       int `json:"created_at"`
    DisconnectedAt  int `json:"disconnected_at"`
    ReconnectedAt   int `json:"reconnected_at"`
}

func main() {
    db, err := sql.Open("sqlite", "/db-data/disconnections.sqlite3")
    if err != nil {
        log.Fatalf("Failed to connect to the database: %v", err)
    }
    defer db.Close()

    http.HandleFunc("/network_disconnections", func(w http.ResponseWriter, r *http.Request) {
        if r.Method != http.MethodGet {
            http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
            return
        }

        disconnections, err := getNetworkDisconnections(db)
        if err != nil {
            http.Error(w, fmt.Sprintf("Failed to fetch data: %v", err), http.StatusInternalServerError)
            return
        }

        w.Header().Set("Content-Type", "application/json")
        if err := json.NewEncoder(w).Encode(disconnections); err != nil {
            http.Error(w, fmt.Sprintf("Failed to encode data: %v", err), http.StatusInternalServerError)
        }
    })

    log.Println("Server running on port 8080")
    http.ListenAndServe(":8080", nil)
}

func getNetworkDisconnections(db *sql.DB) ([]NetworkDisconnection, error) {
	rows, err := db.Query(
        "SELECT id, created_at, disconnected_at, reconnected_at FROM network_disconnections",
    )
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var disconnections []NetworkDisconnection
	for rows.Next() {
		var d NetworkDisconnection
		if err := rows.Scan(&d.ID, &d.CreatedAt, &d.DisconnectedAt, &d.ReconnectedAt); err != nil {
			return nil, err
		}
		disconnections = append(disconnections, d)
	}

	if err := rows.Err(); err != nil {
		return nil, err
	}

	return disconnections, nil
}

