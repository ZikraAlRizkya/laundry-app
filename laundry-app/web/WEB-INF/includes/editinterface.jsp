<style>
    .edit-page {
        min-height: 100vh;
        background: linear-gradient(135deg, #0f172a, #020617);
        display: flex;
        align-items: center;
        justify-content: center;
        font-family: "Segoe UI", sans-serif;
    }

    .edit-wrapper {
        width: 100%;
        max-width: 600px;
        padding: 20px;
    }

    .edit-card {
        background: #ffffff;
        border-radius: 14px;
        padding: 28px 26px;
        box-shadow: 0 20px 40px rgba(0, 0, 0, 0.35);
    }

    .edit-card .form-control,
    .edit-card .form-select {
        border-radius: 10px;
        padding: 10px 12px;
    }

    .edit-card .btn-primary {
        background: #2563eb;
        border-color: #2563eb;
        border-radius: 10px;
        font-weight: 600;
    }

    .edit-card .btn-primary:hover {
        background: #1d4ed8;
    }

    .edit-card .btn-secondary {
        background: #6b7280;
        border-color: #6b7280;
        border-radius: 10px;
        font-weight: 600;
    }

    .edit-card .btn-secondary:hover {
        background: #4b5563;
    }

    .password-wrapper {
        position: relative;
    }

    .password-wrapper .form-control {
        padding-right: 42px;
    }

    .password-toggle {
        position: absolute;
        right: 14px;
        top: 50%;
        transform: translateY(-50%);
        color: #6b7280;
        cursor: pointer;
    }

    .password-toggle:hover {
        color: #2563eb;
    }

    .current-password-display {
        background-color: #f3f4f6;
        padding: 10px 12px;
        border-radius: 10px;
        font-family: monospace;
        font-size: 14px;
        color: #374151;
    }
</style>
